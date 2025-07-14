import warnings
warnings.filterwarnings('ignore', category=FutureWarning)
from flask import abort, render_template, Flask
import logging
import db

APP = Flask(__name__)

# Start page
@APP.route('/')
def index():
    stats = {}
    x = db.execute('SELECT COUNT(*) AS lojas FROM LOJA').fetchone()
    stats.update(x)
    x = db.execute('SELECT COUNT(*) AS fornecedores FROM FORNECEDOR').fetchone()
    stats.update(x)
    x = db.execute('SELECT COUNT(*) AS produtos FROM PRODUTO').fetchone()
    stats.update(x)
    x = db.execute('SELECT COUNT(*) AS funcionarios FROM FUNCIONARIO').fetchone()
    stats.update(x)
    logging.info(stats)
    return render_template('index.html',stats=stats)

# Initialize db
# It assumes a script called db.sql is stored in the sql folder
@APP.route('/init/')
def init(): 
    return render_template('init.html', init=db.init())

# LOJAS
@APP.route('/lojas/')
def list_lojas():
    lojas = db.execute(
      '''
      SELECT Nome
      FROM LOJA
      ORDER BY Nome
      ''').fetchall()
    return render_template('lojas-list.html', lojas=lojas)


@APP.route('/lojas/<expr>/')
def get_loja(expr):
  loja = db.execute(
       ''' 
      SELECT LOJA.Nome,Rua,Num,Andar,Localidade,CodPostal,Responsavel 
      FROM LOJA  
      WHERE LOJA.Nome LIKE %s
      ''', expr).fetchall()

  if loja is None:
     abort(404, 'Loja Name {} does not exist.'.format(expr))

  fornecedores = db.execute(                                    
      '''                                                     
      SELECT Fornecedor, NomeFornecedor
      FROM PRODUTO LEFT JOIN FORNECEDOR ON(FORNECEDOR.NumId=PRODUTO.fornecedor)
      WHERE Loja LIKE %s
      ORDER BY NomeFornecedor
      ''', expr).fetchall();

  produtos = db.execute(
      '''
      SELECT NumId, Nome
      FROM PRODUTO
      WHERE Loja LIKE %s
      ORDER BY Nome
      ''', expr).fetchall()

  funcionarios = db.execute(
      '''
      SELECT Funcionario, Nome                                       
      FROM TRABALHA_PARA LEFT JOIN FUNCIONARIO ON(FUNCIONARIO.NumId=TRABALHA_PARA.Funcionario)
      WHERE Loja LIKE %s 
      ORDER BY Nome
      ''', expr).fetchall();

  return render_template('lojas.html', 
           loja=loja, produtos=produtos, funcionarios=funcionarios, fornecedores=fornecedores)

@APP.route('/lojas/search/<expr>/')
def search_loja(expr):
  search = { 'expr': expr }
  expr = '%' + expr + '%'
  lojas = db.execute(
      ''' 
      SELECT Nome
      FROM LOJA 
      WHERE Nome LIKE %s
      ''', expr).fetchall()
  return render_template('lojas-search.html',
           search=search,lojas=lojas)

# Produtos
@APP.route('/produtos/')
def list_produtos():
    produtos = db.execute('''
      SELECT NumId
      FROM PRODUTO
      ORDER BY Nome
    ''').fetchall()
    return render_template('produtos-list.html', produtos=produtos)


@APP.route('/produtos/<int:id>/')
def view_lojas_by_produto(id):
  produtos = db.execute(
    '''
    SELECT NumId,Nome,Preco_Compra,Preco_Venda,Validade,Fornecedor,Loja
    FROM PRODUTO
    WHERE NumId = %s
    ORDER BY Nome
    ''', id).fetchone()

  if produtos is None:
     abort(404, 'Produto Name {} does not exist.'.format(id))
  
  categorias = db.execute(
    '''
      SELECT NomeCategoria 
      FROM CATEGORIA LEFT JOIN PRODUTO_CATEGORIA ON(CATEGORIA.NumId=PRODUTO_CATEGORIA.CategoriaId) 
      WHERE PRODUTO_CATEGORIA.NumId = %s
      ORDER BY NomeCategoria
    ''', id).fetchall()
       
  lojas = db.execute(
    '''
    SELECT LOJA.Nome
    FROM LOJA LEFT JOIN PRODUTO ON(LOJA.Nome=PRODUTO.Loja)
    WHERE PRODUTO.NumId = %s
    ORDER BY PRODUTO.Nome
    ''', id).fetchall()
    
  fornecedores = db.execute(
    '''
    SELECT FORNECEDOR.NomeFornecedor
    FROM FORNECEDOR LEFT JOIN PRODUTO ON(PRODUTO.Fornecedor=FORNECEDOR.NumId)
    WHERE PRODUTO.NumId = %s
    ORDER BY FORNECEDOR.NomeFornecedor
    ''', id).fetchall()

  return render_template('produtos.html', 
           produtos=produtos,categorias=categorias,lojas=lojas, fornecedores=fornecedores)
 
@APP.route('/produtos/search/<expr>/')
def search_produtos(expr):
  search = { 'expr': expr }
  # SQL INJECTION POSSIBLE! - avoid this!
  produtos = db.execute(
      ' SELECT Nome, NumId'
      ' FROM PRODUTO '
      ' WHERE Nome LIKE \'%' + expr + '%\''
    ).fetchall()

  return render_template('produtos-search.html', 
           search=search,produtos=produtos)

# Fornecedores
@APP.route('/fornecedores/')
def list_fornecedores():
    fornecedores = db.execute('''
      SELECT NomeFornecedor, NumId 
      FROM FORNECEDOR
      ORDER BY NomeFornecedor
    ''').fetchall()
    return render_template('fornecedores-list.html', fornecedores=fornecedores)

@APP.route('/fornecedores/<int:id>/')
def view_lojas_by_fornecedores(id):
  fornecedor = db.execute(
    '''
    SELECT NomeFornecedor,NumId
    FROM FORNECEDOR
    WHERE NumId = %s
    ''', id).fetchone()

  if fornecedor is None:
     abort(404, 'Fornecedor id {} does not exist.'.format(expr))

  produtos = db.execute(
    '''
    SELECT PRODUTO.Nome
    FROM PRODUTO LEFT JOIN FORNECEDOR ON(FORNECEDOR.NumId=PRODUTO.Fornecedor)
    WHERE FORNECEDOR.NumId = %s
    ORDER BY PRODUTO.Nome
    ''', id).fetchall()

  return render_template('fornecedores.html', 
           fornecedor=fornecedor, produtos=produtos)
           
@APP.route('/fornecedores/search/<expr>/')
def search_fornecedores(expr):
  search = { 'expr': expr }
  # SQL INJECTION POSSIBLE! - avoid this!
  fornecedores = db.execute(
      ''' 
      SELECT NomeFornecedor
      FROM FORNECEDOR 
      WHERE NomeFornecedor LIKE %s
      ''', expr).fetchall()

  return render_template('fornecedores-search.html', 
           search=search,fornecedores=fornecedores)           

# Staff
@APP.route('/funcionarios/')
def list_funcionarios():
    funcionarios = db.execute('''
      SELECT NumId
      FROM FUNCIONARIO 
      ORDER BY NumId
    ''').fetchall()
    return render_template('funcionarios-list.html', funcionarios=funcionarios)

@APP.route('/funcionarios/<int:id>/')
def show_funcionarios(id):
  funcionarios = db.execute(
    '''
    SELECT FUNCIONARIO.NumId, Nome, DataNasc, Salario, Email, Numero,Supervisor
    FROM FUNCIONARIO LEFT JOIN TELEMOVEL ON(FUNCIONARIO.NumId=TELEMOVEL.NumId)
    WHERE FUNCIONARIO.NumId = %s
    ''', id).fetchone()

  if funcionarios is None:
     abort(404, 'Funcionario id {} does not exist.'.format(id))
  superv={}
  if not (funcionarios['Supervisor'] is None):
    superv = db.execute(
      '''
      SELECT Nome
      FROM FUNCIONARIO
      WHERE NumId = %s
      ''', funcionarios['Supervisor']).fetchone()
  supervisees = []
  supervisees = db.execute(
    '''
      SELECT NumId, Nome 
      FROM FUNCIONARIO
      WHERE Supervisor = %s
      ORDER BY Nome
    ''',id).fetchall()

  return render_template('funcionarios.html', 
           funcionarios=funcionarios, superv=superv, supervisees=supervisees)

@APP.route('/categorias/')
def list_categorias():
    categorias = db.execute(
      '''
      SELECT NomeCategoria
      FROM CATEGORIA
      ORDER BY NomeCategoria
      ''').fetchall()
    return render_template('categorias-list.html', categorias=categorias)

           
@APP.route('/categorias/<expr>/')
def get_categoria(expr):
  categoria = db.execute(
       ''' 
      SELECT NomeCategoria 
      FROM CATEGORIA
      WHERE NomeCategoria LIKE %s
      ''', expr).fetchall()

  if categoria is None:
     abort(404, 'Categoria Name {} does not exist.'.format(expr))

  produtos = db.execute(
      '''
      SELECT PRODUTO.Nome 
      FROM PRODUTO JOIN PRODUTO_CATEGORIA ON PRODUTO.NumId=PRODUTO_CATEGORIA.NumId JOIN CATEGORIA ON PRODUTO_CATEGORIA.CategoriaId=CATEGORIA.NumId 
      WHERE CATEGORIA.NomeCategoria LIKE %s 
      ORDER BY PRODUTO.Nome
      ''', expr).fetchall()

  return render_template('categorias.html', 
           categoria=categoria, produtos=produtos)
           
           

