# Fib

Elixir OptionParser modülünün kullanımını fibonacci sayısı hesaplayarak örnekleyen bir repo.

İlgili blog yazısı : [https://murat.github.io/2019/05/23/elixir-optionparser-cli-uygulamasi/](https://murat.github.io/2019/05/23/elixir-optionparser-cli-uygulamasi/)

## Kurulum

```bash
git clone git@github.com:murat/ex-fib-cli.git && cd fib

mix escript.build
```

## Kullanım

```bash
➜ mix escript.build && ./fib -n 1000 -c yellow

70330367711422815821835254877183549770181269836358732742604905087154537118196933579742249494562611733487750449241765991088186363265450223647106012053374121273867339111198139373125598767690091902245245323403501

➜ ./fib -n 5 -c red
8

➜ ./fib -n 5 -c asdf
** (RuntimeError) Color asdf is invalid ANSI color!
```

