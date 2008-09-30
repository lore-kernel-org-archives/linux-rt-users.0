From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: RT patches against v2.6.27-rc7 available
Date: Tue, 30 Sep 2008 01:58:34 -0700
Message-ID: <1222765114.30330.7.camel@sven.thebigcorporation.com>
References: <20080930033248.GA24480@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:15646 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYI3I6m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Sep 2008 04:58:42 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1125104tic.23
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Sep 2008 01:58:41 -0700 (PDT)
In-Reply-To: <20080930033248.GA24480@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-09-29 at 23:32 -0400, Paul Gortmaker wrote:

Paul,

=EF=BB=BFFirst of all thanks for taking a shot at the forward-port.


> I've completed a carry forward of the 26rt9 broken out patchset onto
> the 2.6.27-rc7 kernel.  There were a lot of changes in 2.6.27, so thi=
s
> wasn't just a simple case of having all the patches magically work as=
-is.

Never is :)

>=20

A lot of the patches have a lot of fuzz, in my experience, mis-patches
occur more frequently with fuzz.=20

You might want to refresh those patches.

Thanks,

Sven

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
