module ApplicationHelper
  def link_to_task_fields(name, f, association, **args)
    # Cria um novo objeto
    new_object = f.object.send(association).klass.new

    # Pega o id do novo objeto que foi criado
    new_object_id = new_object.object_id

    # Cria os campos para o formulário de task
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    # Passa o link do formulário
    link_to(name, '#', class: 'add_fields ' + args[:class], data:{id: id, fields: fields.gsub("\n","")})
  end
end
