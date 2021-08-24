class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # ao inves de autorizar um de cada vez, pegue da base de dados
      # os registros que o usuario tem direito
      # ex: pessoa so consegue ver restaurantes que ela criou
      # scope => a classe da colecao que eu quero pegar do BD (Restaurant)
      # Restaurant.where(user: current_user)
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    # quem pode entrar na pagina de show de um restaurant?
    true
  end

  def edit?
    # quem pode entrar na pagina de edit de um restaurant?
    # user =>   quem esta tentando acessar a pagina   (current_user)
    # record => restaurante da pagina                 (@restaurant)
    record.user == user || user.admin?
  end

  def update?
    record.user == user || user.admin?
  end

  def destroy?
    record.user == user || user.admin?
  end
end
