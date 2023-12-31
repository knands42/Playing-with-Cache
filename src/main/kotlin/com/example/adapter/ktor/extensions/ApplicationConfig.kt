package com.example.adapter.ktor.extensions

import io.ktor.server.config.*

fun ApplicationConfig.toMap(path: String): Map<String, Any?> =
    config(path).keys().associateBy(
        {
            it
        },
        {
            config(path).property(it).getString()
        }
    )
