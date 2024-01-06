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
class UserController(
    private val logger: Logger,
    private val userRepository: UserRepository,
    private val articleRepository: ArticleRepository,
) {
    @QueryMapping
    @Transactional
    fun user(@Argument id: Int): User? {
        logger.info("user query mapping")
        return userRepository.findByIdOrNull(id)
    }

    @QueryMapping
    @Transactional
    fun users(): List<User> {
        logger.info("users query mapping")
        return userRepository.findAll()
    }

    @BatchMapping(typeName = "User")
    @Transactional
    fun articles(users: List<User>): Map<User, List<Article>> {
        logger.info("User.articles batch mapping")
        val userIds = users.map { it.id }
        val articles = articleRepository.findByAuthorIdIn(userIds).groupBy { it.authorId }
        return users.associateBy({ it }, { articles.getOrDefault(it.id, listOf()) })
    }
}
