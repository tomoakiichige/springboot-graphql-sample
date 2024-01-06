package com.example.springbootgraphqlsample.controller

import com.example.springbootgraphqlsample.entity.Article
import com.example.springbootgraphqlsample.entity.User
import com.example.springbootgraphqlsample.repository.ArticleRepository
import com.example.springbootgraphqlsample.repository.UserRepository
import org.slf4j.Logger
import org.springframework.data.repository.findByIdOrNull
import org.springframework.graphql.data.method.annotation.Argument
import org.springframework.graphql.data.method.annotation.BatchMapping
import org.springframework.graphql.data.method.annotation.QueryMapping
import org.springframework.stereotype.Controller
import org.springframework.transaction.annotation.Transactional

@Controller
class ArticleController(
    private val logger: Logger,
    private val articleRepository: ArticleRepository,
    private val userRepository: UserRepository
) {
    @QueryMapping
    @Transactional
    fun article(@Argument id: Int): Article? {
        logger.info("article query mapping")
        return articleRepository.findByIdOrNull(id)
    }

    @QueryMapping
    @Transactional
    fun articles(): List<Article> {
        logger.info("articles query mapping")
        return articleRepository.findAll()
    }

    @BatchMapping(typeName = "Article")
    @Transactional
    fun author(articles: List<Article>): Map<Article, User> {
        logger.info("Article.author batch mapping")
        val articleIds = articles.map { it.authorId }
        val authors = userRepository.findAllById(articleIds).associateBy { it.id }
        return articles.associateBy({ it }, { authors.getOrElse(it.authorId) { throw Exception() } })
    }
}
