package com.example.springbootgraphqlsample

data class Author(
    val id: String,
    val firstName: String,
    val lastName: String
) {
    companion object {
        private val authors = mutableListOf(
            Author("author-1", "Joshua", "Bloch"),
            Author("author-2", "Douglas", "Adams"),
            Author("author-3", "Bill", "Bryson")
        )

        fun getById(id: String): Author? {
            return authors.firstOrNull { it.id == id }
        }
    }
}
