class ApplicationPresenter
  def initialize(model, view)
    @model = model
    @view = view
  end

  def h
    @view
  end

  private

  def self.presents(name)
    define_method(name) do
      @model
    end
  end
end
