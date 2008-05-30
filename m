From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: Different kernel and RT versions
Date: Fri, 30 May 2008 13:08:00 +0200
Message-ID: <3efb10970805300408p600cd938p9402c064529a4ac6@mail.gmail.com>
References: <10a58eee0805290530r3618ae6ap6cf69aab91c61e28@mail.gmail.com>
	 <10a58eee0805290531lc6ac67cm6d808197b0d41d35@mail.gmail.com>
	 <10a58eee0805290533v32e95d76x25e8fd9954700ee9@mail.gmail.com>
	 <3efb10970805291148u54bff041v5c4ea104d9b9f325@mail.gmail.com>
	 <10a58eee0805292345l12789ff6xc66d5d0e9e54a879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Uli Brueggemann" <uli.brueggemann@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:24564 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbYE3LIB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 May 2008 07:08:01 -0400
Received: by yx-out-2324.google.com with SMTP id 31so421503yxl.1
        for <linux-rt-users@vger.kernel.org>; Fri, 30 May 2008 04:08:00 -0700 (PDT)
In-Reply-To: <10a58eee0805292345l12789ff6xc66d5d0e9e54a879@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Uli,

> But I would like to understand rt differences. That's what I have
> asked for. From viewpoint of application, I do not have a deep Linux
> or even kernel knowledge.

Probably not needed also...

> Or do all the latest rt developments simply
> have no meaning or effect on the application?

Applications do not need to be changed/recompiled to be able to run
them on a rt-kernel.
But, if you want to get the lowest latencies possible, you should
consider adapting the application.
The RT-kernel is not a magic thing making all applications to behave
RT, even if those applications were not designed for it. Bad
applications will always be bad, the RT-kernel will not change that.

You will get lower latencies if your applications use RT-priorities,
but also mlock-ing is required to prevent the application from getting
swapped to disk.
There is also a relation to the priorities of other RT-threads in the
system, and so on.
See also: http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application

Kind Regards,

Remy
