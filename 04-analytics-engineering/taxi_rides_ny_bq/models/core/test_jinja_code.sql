{% for i in range(10) %}
   --{% print (loop.last) %}
   select {{i}} as number {% if not loop.last %} union all {% endif %}

{% endfor %}