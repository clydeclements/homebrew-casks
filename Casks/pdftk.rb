cask :v1 => 'pdftk' do
  version '2.02'
  sha256 'c0679a7a12669480dd298c436b0e4d063966f95ed6a77b98d365bb8c86390d1b'

  url "https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-#{version}-mac_osx-10.6-setup.pkg"
  homepage 'http://www.pdflabs.com/tools/pdftk-server/'
  license :unknown

  preflight do
    system "pkgutil --expand #{staged_path}/pdftk_server-#{version}-mac_osx-10.6-setup.pkg #{staged_path}/expand"
    system "echo '#!/bin/sh' > #{staged_path}/expand/pdftk.pkg/Scripts/postflight"
    system "echo 'exit 0' >> #{staged_path}/expand/pdftk.pkg/Scripts/postflight"
    system "echo '#!/bin/sh' > #{staged_path}/expand/pdftk.pkg/Scripts/postinstall"
    system "echo 'exit 0' >> #{staged_path}/expand/pdftk.pkg/Scripts/postinstall"
    system "rm #{staged_path}/pdftk_server-#{version}-mac_osx-10.6-setup.pkg"
    system "pkgutil --flatten #{staged_path}/expand #{staged_path}/pdftk_server-#{version}-mac_osx-10.6-setup.pkg"
    system "/bin/rm -rf #{staged_path}/expand"
  end

  pkg "pdftk_server-#{version}-mac_osx-10.6-setup.pkg"
  binary '/opt/pdflabs/pdftk/bin/pdftk'

  postflight do
    system '/bin/ln', '-nsf', '--', '/opt/pdflabs/pdftk/man/pdftk.1',
      "#{homebrew_prefix}/share/man/man1/pdftk.1"
  end

  uninstall :pkgutil => 'com.pdflabs.pdftkThePdfToolkit.pdftk.pkg'

  uninstall_postflight do
    system '/bin/rm #{homebrew_prefix}/share/man/man1/pdftk.1'
    system '/bin/rmdir /opt/pdflabs/pdftk'
    system '/bin/rmdir /opt/pdflabs'
  end
end
