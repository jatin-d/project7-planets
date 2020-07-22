def run_sql(sql)
    conn = PG.connect(dbname: 'planets_app')
    record = conn.exec(sql)
    conn.close
    record
end

def read_planets()
    run_sql("select * from planets;")
end

def read_planet_by_id(id)
    run_sql("select * from planets where id=#{id};")[0]
end

def create_planet(name, image_url, diameter, distance, mass, moon_count)
    run_sql("insert into planets (name, image_url, diameter, distance, mass, moon_count) values ('#{name}', '#{image_url}', #{diameter}, #{distance}, #{mass}, #{moon_count});")
end

def delete_planet_by_id(id)
    run_sql("delete from planets where id=#{id};")
end

def update_planet_by_id(name, image_url, diameter, distance, mass, moon_count, id)
    run_sql("update planets set name='#{name}',image_url = '#{image_url}', diameter = #{diameter}, distance = #{distance}, mass = #{mass}, moon_count = #{moon_count} where id=#{id};")
end