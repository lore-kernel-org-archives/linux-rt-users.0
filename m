From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: How to use latency trace
Date: Tue, 13 Nov 2007 18:52:17 +0530
Message-ID: <1985e0f60711130522k4ac274d1o42d63abc2c92b83d@mail.gmail.com>
References: <30746519.1640811193957606209.JavaMail.www@wwinf6101>
	 <1985e0f60711020453o1e8d11e9m4de693d466d5ea57@mail.gmail.com>
	 <1194383628.19313.22.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gerritbinnenmars@wanadoo.nl, linux-rt-users@vger.kernel.org
To: "Sven-Thorsten Dietrich" <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:34694 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbXKMNWT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 08:22:19 -0500
Received: by wr-out-0506.google.com with SMTP id 36so950629wra
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2007 05:22:18 -0800 (PST)
In-Reply-To: <1194383628.19313.22.camel@sx.thebigcorporation.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hello Sven,


On Nov 7, 2007 2:43 AM, Sven-Thorsten Dietrich
<sven@thebigcorporation.com> wrote:
> >
> > you can request for interval for 1000 so it should come 1000 all the
> > time, but it is not.
>
> Its should come CLOSE to 1000. What errors have you seen?
>

My errors are min and avg are not equal to ZERO.
And I will be more happy If max is also ZERO :)

> Have you run latency trace on your workload to identify any long
> code-paths that need to be cleaned up?
>

Yes, I need to do it.

Thanks,

Jaswinder Singh.
