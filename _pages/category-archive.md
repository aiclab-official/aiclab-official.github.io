---
title: "Posts by Category"
layout: splash
permalink: /categories/
author_profile: false
header:
  overlay_color: "#5e616c"
  overlay_image: /assets/images/AICLAB.png
  overlay_filter: 0.5
---

<style>
/* Custom styles for category cards */
.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2em;
  margin: 2em 0;
}

.category-card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  text-decoration: none;
  color: inherit;
  display: block;
  width: 100%;
  position: relative;
}

.category-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(0,0,0,0.15);
  text-decoration: none;
  color: inherit;
}

.category-header {
  position: relative;
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  overflow: hidden;
}

.category-header.systemverilog {
  background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
}

.category-header.sta {
  background: linear-gradient(135deg, #FF9800 0%, #F57C00 100%);
}

.category-header.verification {
  background: linear-gradient(135deg, #2196F3 0%, #1565C0 100%);
}

.category-header.uvm {
  background: linear-gradient(135deg, #9C27B0 0%, #6A1B9A 100%);
}

.category-icon {
  font-size: 3em;
  margin-bottom: 0.5em;
  opacity: 0.9;
}

.category-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0.3;
}

.category-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.4);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  z-index: 1;
}

.category-title {
  font-size: 1.5em;
  font-weight: bold;
  margin: 0;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.category-count {
  font-size: 0.9em;
  opacity: 0.9;
  margin-top: 0.5em;
}

.category-body {
  padding: 1.5em;
  position: relative;
  z-index: 1;
}

.category-description {
  color: #666;
  line-height: 1.6;
  margin-bottom: 1em;
  text-align: left;
  word-wrap: break-word;
}

.category-topics {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5em;
}

.topic-tag {
  background: #f0f0f0;
  color: #666;
  padding: 0.2em 0.6em;
  border-radius: 12px;
  font-size: 0.8em;
  text-decoration: none;
}

.topic-tag:hover {
  background: #007acc;
  color: white;
  text-decoration: none;
}

@media (max-width: 768px) {
  .category-grid {
    grid-template-columns: 1fr;
    gap: 1em;
  }
  
  .category-header {
    height: 150px;
  }
  
  .category-title {
    font-size: 1.3em;
  }
}
</style>

<div class="category-grid">
  {% assign categories = site.categories | sort %}
  {% for category in categories %}
    {% assign category_name = category[0] %}
    {% assign posts = category[1] %}
    {% assign category_slug = category_name | slugify %}
    
    <a href="#{{ category_slug }}" class="category-card" onclick="document.getElementById('{{ category_slug }}').scrollIntoView({behavior: 'smooth'});">
      <div class="category-header {{ category_slug }}">
        {% if category_name == "SystemVerilog" %}
          <img src="/assets/images/1- LevelOfAbstraction.png" alt="{{ category_name }}" class="category-image">
        {% elsif category_name == "STA" %}
          <img src="/assets/images/2- Design flow.png" alt="{{ category_name }}" class="category-image">
        {% elsif category_name == "Verification" %}
          <img src="/assets/images/3- Simulation_Synthesis.png" alt="{{ category_name }}" class="category-image">
        {% endif %}
        
        <div class="category-overlay">
          <div class="category-icon">
            {% if category_name == "SystemVerilog" %}
              <i class="fas fa-microchip"></i>
            {% elsif category_name == "STA" %}
              <i class="fas fa-clock"></i>
            {% elsif category_name == "Verification" %}
              <i class="fas fa-check-circle"></i>
            {% elsif category_name == "UVM" %}
              <i class="fas fa-cogs"></i>
            {% else %}
              <i class="fas fa-folder"></i>
            {% endif %}
          </div>
          <h3 class="category-title">{{ category_name }}</h3>
          <div class="category-count">{{ posts.size }} post{% if posts.size != 1 %}s{% endif %}</div>
        </div>
      </div>
      
      <div class="category-body">
        <div class="category-description">
          {% if category_name == "SystemVerilog" %}
            Digital circuit design, FPGA and ASIC development, RTL coding, and SystemVerilog language fundamentals.
          {% elsif category_name == "STA" %}
            Static Timing Analysis, timing constraints, clock domain crossing, and timing closure techniques.
          {% elsif category_name == "Verification" %}
            Testbench development, verification methodologies, and validation strategies for digital designs.
          {% elsif category_name == "UVM" %}
            Universal Verification Methodology, advanced testbench architectures, and verification components.
          {% else %}
            Explore posts in this category to learn more about {{ category_name }}.
          {% endif %}
        </div>
        
        <div class="category-topics">
          {% assign all_tags = "" | split: "," %}
          {% for post in posts limit: 10 %}
            {% for tag in post.tags %}
              {% unless all_tags contains tag %}
                {% assign all_tags = all_tags | push: tag %}
              {% endunless %}
            {% endfor %}
          {% endfor %}
          {% for tag in all_tags limit: 6 %}
            <span class="topic-tag">{{ tag }}</span>
          {% endfor %}
        </div>
      </div>
    </a>
  {% endfor %}
  
  <!-- Coming Soon Categories -->
  {% unless site.categories contains "STA" %}
    <div class="category-card" style="opacity: 0.7;">
      <div class="category-header sta">
        <div class="category-overlay">
          <div class="category-icon">
            <i class="fas fa-clock"></i>
          </div>
          <h3 class="category-title">STA</h3>
          <div class="category-count">Coming Soon</div>
        </div>
      </div>
      
      <div class="category-body">
        <div class="category-description">
          Static Timing Analysis, timing constraints, clock domain crossing, and timing closure techniques.
        </div>
        
        <div class="category-topics">
          <span class="topic-tag">Timing Analysis</span>
          <span class="topic-tag">Clock Constraints</span>
          <span class="topic-tag">Setup/Hold</span>
          <span class="topic-tag">Clock Skew</span>
        </div>
      </div>
    </div>
  {% endunless %}
  
  {% unless site.categories contains "Verification" %}
    <div class="category-card" style="opacity: 0.7;">
      <div class="category-header verification">
        <div class="category-overlay">
          <div class="category-icon">
            <i class="fas fa-check-circle"></i>
          </div>
          <h3 class="category-title">Verification</h3>
          <div class="category-count">Coming Soon</div>
        </div>
      </div>
      
      <div class="category-body">
        <div class="category-description">
          Testbench development, verification methodologies, and validation strategies for digital designs.
        </div>
        
        <div class="category-topics">
          <span class="topic-tag">Testbenches</span>
          <span class="topic-tag">Assertions</span>
          <span class="topic-tag">Coverage</span>
          <span class="topic-tag">Debugging</span>
        </div>
      </div>
    </div>
  {% endunless %}
</div>

<!-- Detailed Category Sections -->
{% for category in categories %}
  {% assign category_name = category[0] %}
  {% assign posts = category[1] %}
  {% assign category_slug = category_name | slugify %}
  
  <section id="{{ category_slug }}" style="margin-top: 4em; padding-top: 2em; border-top: 2px solid #f0f0f0;">
    <h2 style="color: #333; margin-bottom: 1.5em;">
      <i class="fas fa-{% if category_name == 'SystemVerilog' %}microchip{% elsif category_name == 'STA' %}clock{% elsif category_name == 'Verification' %}check-circle{% else %}folder{% endif %}" style="margin-right: 0.5em; color: #007acc;"></i>
      {{ category_name }} Posts
    </h2>
    
    <div class="posts-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5em;">
      {% for post in posts %}
        <article style="background: #fff; border: 1px solid #e0e0e0; border-radius: 8px; overflow: hidden; transition: transform 0.2s ease, box-shadow 0.2s ease;">
          {% if post.header.teaser %}
            <div style="height: 150px; background-image: url('{{ post.header.teaser | relative_url }}'); background-size: cover; background-position: center;"></div>
          {% endif %}
          
          <div style="padding: 1.2em;">
            <h3 style="margin: 0 0 0.5em 0; font-size: 1.1em; line-height: 1.3;">
              <a href="{{ post.url | relative_url }}" style="color: #333; text-decoration: none;">{{ post.title }}</a>
            </h3>
            
            <div style="font-size: 0.9em; color: #666; margin-bottom: 0.8em;">
              {{ post.date | date: "%B %d, %Y" }}
            </div>
            
            {% if post.excerpt %}
              <p style="color: #666; font-size: 0.9em; line-height: 1.5; margin-bottom: 1em;">
                {{ post.excerpt | strip_html | truncatewords: 20 }}
              </p>
            {% endif %}
            
            {% if post.tags %}
              <div style="display: flex; flex-wrap: wrap; gap: 0.3em;">
                {% for tag in post.tags limit: 3 %}
                  <span style="background: #f0f0f0; color: #666; padding: 0.2em 0.5em; border-radius: 3px; font-size: 0.75em;">{{ tag }}</span>
                {% endfor %}
              </div>
            {% endif %}
          </div>
        </article>
      {% endfor %}
    </div>
    
    <div style="text-align: center; margin-top: 2em;">
      <a href="#page-title" style="color: #007acc; text-decoration: none; font-weight: 500;">
        <i class="fas fa-arrow-up"></i> Back to Top
      </a>
    </div>
  </section>
{% endfor %}
