FactoryBot.define do

    factory :getty_image do
      sequence(:embed_code) { |n| "<a id='jzcKMFBQSlRMIGbBKsM_cw' class='gie-single' href='http://www.gettyimages.co.uk/detail/1023701514#{n}' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'jzcKMFBQSlRMIGbBKsM_cw',sig:'AboXIdGt3QTGNFQVz099ZClMoWqDMRbsaZFTrm7oVrs=',w:'339px',h:'509px',items:'1023701514#{n}',caption: true ,tld:'co.uk',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>" }
      association :animon
    end

  end
