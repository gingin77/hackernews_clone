class ApplicationPresenter
  def initialize(model, view)
    @model = model
    @view = view
  end

  def h
    @view
  end
end
