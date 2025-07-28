import Head from 'next/head'

export default function Home() {
  return (
    <>
      <Head>
        <title>Brimes Portfolio</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head>
      <header id="headerInicio" style={{padding:"2rem", textAlign:"center"}}>
        <h1>Brimes</h1>
        <nav>
          <a href="#divBlog">Blog</a> |{' '}
          <a href="#divApps">Apps</a> |{' '}
          <a href="#divAbout">Sobre mim</a> |{' '}
          <a href="#divContact">Contato</a>
        </nav>
      </header>

      <main>
        <section id="divBlog">
          <h2>Meu Blog</h2>
          <p>Coisas para ler....</p>
        </section>

        <section id="divApps">
          <h2>Apps</h2>
        </section>

        <section id="divAbout">
          <h2>Sobre mim</h2>
          <p>Bruno de Lima Soares</p>
        </section>

        <section id="divContact">
          <h2>Entre em contato</h2>
          <p>brunodelima@gmail.com</p>
        </section>
      </main>

      <footer style={{textAlign:"center", marginTop:"2rem"}}>
        © Bruno de Lima Soares (Brimes)
      </footer>
    </>
  )
}
