---
title: "All Posts"
layout: splash
permalink: /posts/
pagination: 
  enabled: true
author_profile: false
classes: wide
header:
  overlay_color: "#000"
  overlay_filter: 0.3
---

<style>
/* Modern posts grid styling */
.posts-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2em 1em;
}

.posts-header {
  text-align: center;
  margin-bottom: 3em;
}

.posts-header h1 {
  font-size: 2.5em;
  color: #333;
  margin-bottom: 0.5em;
  font-weight: 300;
}

.posts-header p {
  font-size: 1.1em;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
}

.posts-stats {
  display: flex;
  justify-content: center;
  gap: 2em;
  margin: 2em 0;
  flex-wrap: wrap;
}

.stat-item {
  text-align: center;
  padding: 1em;
  background: #f8f9fa;
  border-radius: 8px;
  min-width: 120px;
}

.stat-number {
  font-size: 2em;
  font-weight: bold;
  color: #007acc;
  display: block;
}

.stat-label {
  font-size: 0.9em;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2em;
  margin: 2em 0;
}

.post-card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.post-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.post-image {
  position: relative;
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  overflow: hidden;
}

.post-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.post-card:hover .post-image img {
  transform: scale(1.05);
}

.post-category-badge {
  position: absolute;
  top: 1em;
  left: 1em;
  background: rgba(255,255,255,0.95);
  color: #2E7D32;
  padding: 0.3em 0.8em;
  border-radius: 20px;
  font-size: 0.6em;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.2s ease;
  border: 2px solid rgba(46,125,50,0.3);
  text-shadow: none;
}

.post-category-badge:hover {
  background: #2E7D32;
  color: white;
  text-decoration: none;
  border-color: #2E7D32;
  transform: translateY(-1px);
}

.post-content {
  padding: 1.5em;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.post-title {
  font-size: 1.3em;
  font-weight: 600;
  line-height: 1.3;
  margin-bottom: 0.5em;
}

.post-title a {
  color: #333;
  text-decoration: none;
  transition: color 0.2s ease;
}

.post-title a:hover {
  color: #007acc;
  text-decoration: none;
}

.post-meta {
  display: flex;
  align-items: center;
  gap: 1em;
  margin-bottom: 1em;
  font-size: 0.9em;
  color: #666;
}

.post-date {
  display: flex;
  align-items: center;
  gap: 0.3em;
}

.post-excerpt {
  color: #666;
  line-height: 1.6;
  margin-bottom: 1.5em;
  flex: 1;
}

.post-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5em;
  margin-top: auto;
}

.post-tag {
  background: #f0f0f0;
  color: #666;
  padding: 0.2em 0.6em;
  border-radius: 12px;
  font-size: 0.8em;
  text-decoration: none;
  transition: all 0.2s ease;
}

.post-tag:hover {
  background: #007acc;
  color: white;
  text-decoration: none;
}

.read-more {
  display: inline-flex;
  align-items: center;
  gap: 0.5em;
  color: #007acc;
  font-weight: 500;
  text-decoration: none;
  margin-top: 1em;
  font-size: 0.9em;
  transition: gap 0.2s ease;
}

.read-more:hover {
  color: #0056b3;
  text-decoration: none;
  gap: 0.8em;
}

/* Modern pagination styling */
.modern-pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5em;
  margin: 3em 0;
  flex-wrap: wrap;
}

.pagination-btn {
  padding: 0.8em 1.2em;
  border: 1px solid #ddd;
  background: #fff;
  color: #666;
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.2s ease;
  font-weight: 500;
  min-width: 44px;
  text-align: center;
}

.pagination-btn:hover {
  background: #007acc;
  color: white;
  border-color: #007acc;
  text-decoration: none;
}

.pagination-btn.current {
  background: #007acc;
  color: white;
  border-color: #007acc;
}

.pagination-btn.disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pagination-btn.disabled:hover {
  background: #fff;
  color: #666;
  border-color: #ddd;
}

/* Loading animation */
.post-card {
  animation: fadeInUp 0.6s ease forwards;
  opacity: 0;
  transform: translateY(20px);
}

.post-card:nth-child(1) { animation-delay: 0.1s; }
.post-card:nth-child(2) { animation-delay: 0.2s; }
.post-card:nth-child(3) { animation-delay: 0.3s; }
.post-card:nth-child(4) { animation-delay: 0.4s; }
.post-card:nth-child(5) { animation-delay: 0.5s; }
.post-card:nth-child(6) { animation-delay: 0.6s; }

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive design */
@media (max-width: 768px) {
  .posts-container {
    padding: 1em 0.5em;
  }
  
  .posts-header h1 {
    font-size: 2em;
  }
  
  .posts-grid {
    grid-template-columns: 1fr;
    gap: 1.5em;
  }
  
  .post-image {
    height: 150px;
  }
  
  .posts-stats {
    gap: 1em;
  }
  
  .stat-item {
    min-width: 100px;
    padding: 0.8em;
  }
  
  .modern-pagination {
    gap: 0.3em;
  }
  
  .pagination-btn {
    padding: 0.6em 1em;
    font-size: 0.9em;
  }
}

@media (max-width: 480px) {
  .post-content {
    padding: 1em;
  }
  
  .post-title {
    font-size: 1.1em;
  }
  
  .posts-stats {
    flex-direction: column;
    align-items: center;
  }
}
</style>

<div class="posts-container">
  <div class="posts-header">
    <h1>Our Technical Blog</h1>
    <p>Dive deep into digital design, SystemVerilog, FPGA development, and cutting-edge hardware engineering concepts. Each post is crafted to provide practical insights and advanced techniques.</p>
  </div>

  <div class="posts-stats">
    <div class="stat-item">
      <span class="stat-number">{{ site.posts.size }}</span>
      <span class="stat-label">Total Posts</span>
    </div>
    <div class="stat-item">
      <span class="stat-number">{{ site.categories.size }}</span>
      <span class="stat-label">Categories</span>
    </div>
    <div class="stat-item">
      {% assign all_tags = site.posts | map: 'tags' | flatten | uniq %}
      <span class="stat-number">{{ all_tags.size }}</span>
      <span class="stat-label">Topics</span>
    </div>
  </div>

  <div class="posts-grid">
    {% if paginator.posts %}
      {% for post in paginator.posts %}
        <article class="post-card">
          <div class="post-image">
            {% if post.header.teaser %}
              <img src="{{ post.header.teaser | relative_url }}" alt="{{ post.title }}">
            {% else %}
              <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%); display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-microchip" style="font-size: 3em; color: rgba(255,255,255,0.8);"></i>
              </div>
            {% endif %}
            {% if post.categories.first %}
              <a href="/categories/#{{ post.categories.first | slugify }}" class="post-category-badge">
                {{ post.categories.first }}
              </a>
            {% endif %}
          </div>
          
          <div class="post-content">
            <h2 class="post-title">
              <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
            </h2>
            
            <div class="post-meta">
              <div class="post-date">
                <i class="fas fa-calendar-alt"></i>
                {{ post.date | date: "%B %d, %Y" }}
              </div>
              <div class="post-read-time">
                <i class="fas fa-clock"></i>
                {% assign words = post.content | number_of_words %}
                {% if words < 180 %}
                  1 min read
                {% else %}
                  {{ words | divided_by: 180 }} min read
                {% endif %}
              </div>
            </div>
            
            {% if post.excerpt %}
              <div class="post-excerpt">
                {{ post.excerpt | strip_html | truncatewords: 25 }}
              </div>
            {% endif %}
            
            <div class="post-tags">
              {% for tag in post.tags limit: 4 %}
                <a href="/tags/#{{ tag | slugify }}" class="post-tag">{{ tag }}</a>
              {% endfor %}
            </div>
            
            <a href="{{ post.url | relative_url }}" class="read-more">
              Read More <i class="fas fa-arrow-right"></i>
            </a>
          </div>
        </article>
      {% endfor %}
    {% else %}
      {% for post in site.posts %}
        <article class="post-card">
          <div class="post-image">
            {% if post.header.teaser %}
              <img src="{{ post.header.teaser | relative_url }}" alt="{{ post.title }}">
            {% else %}
              <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%); display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-microchip" style="font-size: 3em; color: rgba(255,255,255,0.8);"></i>
              </div>
            {% endif %}
            {% if post.categories.first %}
              <a href="/categories/#{{ post.categories.first | slugify }}" class="post-category-badge">
                {{ post.categories.first }}
              </a>
            {% endif %}
          </div>
          
          <div class="post-content">
            <h2 class="post-title">
              <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
            </h2>
            
            <div class="post-meta">
              <div class="post-date">
                <i class="fas fa-calendar-alt"></i>
                {{ post.date | date: "%B %d, %Y" }}
              </div>
              <div class="post-read-time">
                <i class="fas fa-clock"></i>
                {% assign words = post.content | number_of_words %}
                {% if words < 180 %}
                  1 min read
                {% else %}
                  {{ words | divided_by: 180 }} min read
                {% endif %}
              </div>
            </div>
            
            {% if post.excerpt %}
              <div class="post-excerpt">
                {{ post.excerpt | strip_html | truncatewords: 25 }}
              </div>
            {% endif %}
            
            <div class="post-tags">
              {% for tag in post.tags limit: 4 %}
                <a href="/tags/#{{ tag | slugify }}" class="post-tag">{{ tag }}</a>
              {% endfor %}
            </div>
            
            <a href="{{ post.url | relative_url }}" class="read-more">
              Read More <i class="fas fa-arrow-right"></i>
            </a>
          </div>
        </article>
      {% endfor %}
    {% endif %}
  </div>

  <!-- Modern Pagination -->
  {% if paginator.total_pages > 1 %}
  <nav class="modern-pagination">
    {% if paginator.previous_page %}
      <a href="{{ paginator.previous_page_path | relative_url }}" class="pagination-btn">
        <i class="fas fa-chevron-left"></i> Previous
      </a>
    {% else %}
      <span class="pagination-btn disabled">
        <i class="fas fa-chevron-left"></i> Previous
      </span>
    {% endif %}
    
    {% for page in (1..paginator.total_pages) %}
      {% if page == paginator.page %}
        <span class="pagination-btn current">{{ page }}</span>
      {% elsif page == 1 %}
        <a href="{{ '/posts/' | relative_url }}" class="pagination-btn">{{ page }}</a>
      {% else %}
        <a href="{{ '/posts/page/' | append: page | append: '/' | relative_url }}" class="pagination-btn">{{ page }}</a>
      {% endif %}
    {% endfor %}
    
    {% if paginator.next_page %}
      <a href="{{ paginator.next_page_path | relative_url }}" class="pagination-btn">
        Next <i class="fas fa-chevron-right"></i>
      </a>
    {% else %}
      <span class="pagination-btn disabled">
        Next <i class="fas fa-chevron-right"></i>
      </span>
    {% endif %}
  </nav>
  {% endif %}
</div>
