From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: Different kernel and RT versions
Date: Thu, 29 May 2008 20:48:30 +0200
Message-ID: <3efb10970805291148u54bff041v5c4ea104d9b9f325@mail.gmail.com>
References: <10a58eee0805290530r3618ae6ap6cf69aab91c61e28@mail.gmail.com>
	 <10a58eee0805290531lc6ac67cm6d808197b0d41d35@mail.gmail.com>
	 <10a58eee0805290533v32e95d76x25e8fd9954700ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Uli Brueggemann" <uli.brueggemann@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:65394 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYE2Ssc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 May 2008 14:48:32 -0400
Received: by yx-out-2324.google.com with SMTP id 31so376649yxl.1
        for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 11:48:31 -0700 (PDT)
In-Reply-To: <10a58eee0805290533v32e95d76x25e8fd9954700ee9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Uli,

> I like to use Linux for audio purposes.
> So of course I'm interested in getting a best performance.

What do you mean exactly with 'performance' ? (speed versus 'a nice
play/showtime')

Realtime is not about performance (in the sense of speed), it is about
determinism.

So, if you want a fast system, you probably do not want realtime.
If you want a predictable (low latency) system, you could think about realtime.

> Can someone explain me how to select a kernel and the rt-version? What
> are advantages/disadvantages under realtime aspects?

Already looked on http://rt.wiki.kernel.org ??


Kind Regards,

Remy

>
> Now I can see that there are constant updates of rt-versions:
> - 2.6.24.7 now there is rt11
> - 2.6.25.4 we have rt3
> - 2.6.26-rc4 no rt work yet published
>
> It seems that the rt-versions for the different kernels are maintained
> in parallel but e.g. last updates have been for 2.6.24.7
>
> Can someone explain me how to select a kernel and the rt-version? What
> are advantages/disadvantages under realtime aspects?
>
> Thanks
>
> Uli
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
