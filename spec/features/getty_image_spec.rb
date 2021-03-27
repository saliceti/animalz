feature 'Getty image' do
    scenario 'Add' do
      given_an_animon_exists
      when_a_user_visits_the_animon
      and_clicks_on_add_getty_image
      and_adds_a_getty_image
      then_the_getty_image_is_displayed
    end

    def given_an_animon_exists
      @animon = create(:animon)
    end

    def when_a_user_visits_the_animon
      visit animon_path(@animon)
    end

    def and_clicks_on_add_getty_image
      click_link "Add Getty image"
    end

    def and_adds_a_getty_image
      expect(page).to have_text "Add Getty image to #{@animon.taxon.common_name}"
      expect(page).to have_field "getty_image_animon_id", with: @animon.id, type: :hidden
      @embed_code = "<a id='6MtdDoJtRVZW-pyPUAMbOQ' class='gie-single' href='http://www.gettyimages.co.uk/detail/452372-001' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'6MtdDoJtRVZW-pyPUAMbOQ',sig:'sGMKiGW4buFm5VU7rKjkeNCpCG-84OKuDTxwVyEp5YA=',w:'502px',h:'341px',items:'452372-001',caption: true ,tld:'co.uk',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>"
      fill_in :getty_image_embed_code, with: @embed_code
      click_button 'commit'
    end

    def then_the_getty_image_is_displayed
      expect(current_path).to eq(animon_path(@animon))
      getty_image = GettyImage.last
      expect(page).to have_css("a[href='http://www.gettyimages.co.uk/detail/452372-001']")
    end
  end
