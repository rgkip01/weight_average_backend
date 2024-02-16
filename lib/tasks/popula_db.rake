namespace :db do
  desc "Crie dados de teste com 1.000 projetos, cada um com 5 avaliações e cada avaliação com 5 critérios diferentes"
  task create_test_data: :environment do
    puts "Criando dados de Teste no banco (DEV)..."

    criterios = Array.new(5) { |i| Criterio.find_or_create_by!(peso: i+1) }

    ActiveRecord::Base.transaction do
      1000.times do |i|
        projeto = Projeto.create!(nome: "Projeto #{i+1}")

        5.times do
          avaliacao = projeto.avaliacoes.build

          criterios.each do |criterio|
            nota = Faker::Number.between(from: 0.0, to: 10.0).round(2)
            avaliacao.notas.build(nota: nota, criterio: criterio)
          end

          servico = CalculoMediaService.new(avaliacao: avaliacao)
          avaliacao.media_ponderada = servico.calcular_media_ponderada

          avaliacao.save! # Salva a avaliação com a media_ponderada já calculada
        end
      end
    end

    puts "Base populada com sucesso!"
  end
end
