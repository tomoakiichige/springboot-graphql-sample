package com.example.springbootgraphqlsample.repository

import com.example.springbootgraphqlsample.entity.Article
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ArticleRepository : JpaRepository<Article, Int> {
    fun findByAuthorIdIn(authorIds: List<Int>): List<Article>
}
