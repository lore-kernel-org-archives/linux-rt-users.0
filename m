From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: How to use latency trace
Date: Fri, 2 Nov 2007 17:23:48 +0530
Message-ID: <1985e0f60711020453o1e8d11e9m4de693d466d5ea57@mail.gmail.com>
References: <30746519.1640811193957606209.JavaMail.www@wwinf6101>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: gerritbinnenmars@wanadoo.nl
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:27653 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbXKBLxt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Nov 2007 07:53:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so641688nze
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Nov 2007 04:53:48 -0700 (PDT)
In-Reply-To: <30746519.1640811193957606209.JavaMail.www@wwinf6101>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hello Gerrit Binnenmars,


On 11/2/07, Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl> wrote:
>
> Another question: can you ever guarantee a max. latency if a user has access
> to the system?
>

I do not think so. this shows this is soft real time.

It best example is :

http://rt.wiki.kernel.org/index.php/Cyclictest

you can request for interval for 1000 so it should come 1000 all the
time, but it is not.

Thank you,

Jaswinder Singh.
