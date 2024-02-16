# db/seeds.rb
5.times do |i|
  criterio = Criterio.create(peso: rand(1.0..5.0))
  projeto = Projeto.create(nome: "Projeto #{i + 1}", media_total: 0.0)

  5.times do
    avaliacao = Avaliacao.create(projeto: projeto, media_ponderada: 0.0)

    5.times do
      Nota.create(nota: rand(1.0..10.0), avaliacao: avaliacao, criterio: criterio)
    end
  end
end

Projeto.find_each do |projeto|
  servico_projeto = CalculoMediaService.new(projeto: projeto)
  projeto.update(media_total: servico_projeto.calcular_media_total)
end
