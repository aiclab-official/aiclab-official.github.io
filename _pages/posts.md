---
title: "All Posts"
layout: single
permalink: /posts/
paginate: true
author_profile: true
classes: wide
---

<style>
/* Custom styles for scaling images in posts grid */
.grid__item .archive__item-teaser img {
  max-height: 150px !important;
  width: 100% !important;
  object-fit: cover !important;
  border-radius: 4px !important;
}

@media (max-width: 768px) {
  .grid__item .archive__item-teaser img {
    max-height: 120px !important;
  }
}
</style>

<div class="grid__wrapper">
  {% if paginator.posts %}
    {% for post in paginator.posts %}
      {% include archive-single.html type="grid" %}
    {% endfor %}
  {% else %}
    {% for post in site.posts %}
      {% include archive-single.html type="grid" %}
    {% endfor %}
  {% endif %}
</div>

<!-- Pagination controls -->
{% if paginator.total_pages > 1 %}
<nav class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}" class="pagination--pager">‹ Previous</a>
  {% endif %}
  
  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      <em class="current">{{ page }}</em>
    {% elsif page == 1 %}
      <a href="{{ '/posts/' | relative_url }}">{{ page }}</a>
    {% else %}
      <a href="{{ '/posts/page/' | append: page | append: '/' | relative_url }}">{{ page }}</a>
    {% endif %}
  {% endfor %}
  
  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | relative_url }}" class="pagination--pager">Next ›</a>
  {% endif %}
</nav>
{% endif %}
