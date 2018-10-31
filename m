Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36836 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbeJaWvv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Oct 2018 18:51:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so14909550lji.3
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Oct 2018 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <d71c523a8a0af5628da59a44223a357102c2a193.1540627754.git.lukas@wunner.de>
 <CACRpkdZfciHUrx9YTFsYyKEEi6RMDeWxYqe7JPnJJipWOyUJ6A@mail.gmail.com> <20181029144507.GB9137@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20181029144507.GB9137@jcartwri.amer.corp.natinst.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Oct 2018 14:53:30 +0100
Message-ID: <CACRpkdZwhX9Db1Y4w60sJyCsS7=DRLX1ffg=8knh-GLZCDeiwQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Lukas Wunner <lukas@wunner.de>, Grygorii Strashko <grygorii.strashko@ti.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Mathias Duckeck <m.duckeck@kunbus.de>, Tiejun Chen <tiejun.china@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-rt-users@vger.kernel.org

On Mon, Oct 29, 2018 at 3:45 PM Julia Cartwright <julia@ni.com> wrote:

> The change seems reasonable to me.

Thanks. (I record that as an Acked-by.)

> As a side note: the bitops used to manage the enabled_irq_map are the
> atomic variants (set_bit, etc), is this actually necessary?  In other
> words, are they ever accessed outside of the spinlock?

Lukas can you look into this?

On a further side note I have developed an aversion toward the
implicit semantics in __set_bit() for non-atomic set_bit(), I was
thinking to send Torvalds something like a sed script to simply
rename all the __set_bit() and friends to set_bit_nonatomic() etc
or set_bit_na() so it becomes human readable that he could
run before finalizing the next kernel. If people think it is a good
idea.

Yours,
Linus Walleij
