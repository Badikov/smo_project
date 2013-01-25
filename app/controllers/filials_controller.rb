# encoding: utf-8
class FilialsController < ApplicationController
  
  before_filter :require_user
  # GET /filials
  # GET /filials.json
  def index
    @filials = Filial.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @filials }
    end
  end

  # GET /filials/1
  # GET /filials/1.json
  def show
    @filial = Filial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @filial }
    end
  end

  # GET /filials/new
  # GET /filials/new.json
  def new
    @filial = Filial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @filial }
    end
  end

  # GET /filials/1/edit
  def edit
    @filial = Filial.find(params[:id])
  end

  # POST /filials
  # POST /filials.json
  def create
    @filial = Filial.new(params[:filial])

    respond_to do |format|
      if @filial.save
        format.html { redirect_to @filial, notice: 'Добавлен новый филиал.' }
        format.json { render json: @filial, status: :created, location: @filial }
      else
        format.html { render action: "new" }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /filials/1
  # PUT /filials/1.json
  def update
    @filial = Filial.find(params[:id])

    respond_to do |format|
      if @filial.update_attributes(params[:filial])
        format.html { redirect_to @filial, notice: 'Информация о филиале успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filials/1
  # DELETE /filials/1.json
  def destroy
    @filial = Filial.find(params[:id])
    @filial.destroy

    respond_to do |format|
      format.html { redirect_to filials_url }
      format.json { head :no_content }
    end
  end
end
