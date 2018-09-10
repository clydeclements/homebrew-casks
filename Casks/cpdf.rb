cask 'cpdf' do
  version '2.2.1'
  sha256 '052b583f2b6d115c671d53d78c974f73c1fd33a6388efc29c54084af4b112529'

  # Download based on commit SHA corresponding to this version.
  # github.com/coherentgraphics was verified as official when first introduced to the cask
  url "https://github.com/coherentgraphics/cpdf-binaries/archive/8e308f25a329e6ac3728a69afdc1ef531a24767c.zip"
  name 'PDF Command Line Tools'
  homepage 'https://community.coherentpdf.com/'

  binary "#{staged_path}/cpdf-binaries-8e308f25a329e6ac3728a69afdc1ef531a24767c/OSX-Intel/cpdf", target: 'cpdf'
end
