package com.example.springbootgraphqlsample.repository

import com.example.springbootgraphqlsample.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface UserRepository : JpaRepository<User, Int>
