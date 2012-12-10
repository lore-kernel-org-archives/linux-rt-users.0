From: jordan <triplesquarednine@gmail.com>
Subject: Re: 3.2 kernel?
Date: Mon, 10 Dec 2012 12:23:57 -0500
Message-ID: <CAOcfFMyhsh=S6EqN7xGZk4wnhxqMFZqtvAWUA+PtmsvGAxYTuQ@mail.gmail.com>
References: <CA+2XN5JRkNDi52k57fzXue1HjaqD5wJdZXLessMDz94mKfXc_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Ho Wan Chan <smartboyhw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41881 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2LJRX7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Dec 2012 12:23:59 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so2664410vby.19
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Dec 2012 09:23:58 -0800 (PST)
In-Reply-To: <CA+2XN5JRkNDi52k57fzXue1HjaqD5wJdZXLessMDz94mKfXc_A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hi guys.

Hi.

> Sorry if I have asked anything wrong, but now since the kernel is now
> at 3.2.35 but then the -rt patch is still at 3.2.34, I wondered why
> the .35 patch is still not yet released.

Note: I am not an linux-rt maintainer.... but i don't think there is
some 'rule' or mandate that says the rt-devs must do point releases at
the _exact_same_time_ as the official kernels are pushed...

out of curiosity - is there some specific addition to .35 over .34
that would explain why a .35-rt release is so urgent (to you)?

> Anyway I tried applying the 3.2.34 patch onto 3.2.35 and it didn't
> give out any errors.

it looks like you have a working 3.2.35-rt kernel then ;)

cheerz

Jordan
