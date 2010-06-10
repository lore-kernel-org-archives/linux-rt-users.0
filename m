From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: At a loss: Kernel 2.6.19-rt15 with ixp425
Date: Wed, 09 Jun 2010 19:25:22 -0700
Message-ID: <1276136722.4686.1.camel@sven.thebigcorporation.com>
References: <20100608181752.GA19521@colorado.edu>
	 <1276022232.9420.17.camel@sven.thebigcorporation.com>
	 <20100608193204.GA13883@colorado.edu>
	 <1276102964.8203.7.camel@sven.thebigcorporation.com>
	 <AANLkTindPmnb9Ct6G36drF-FrV8OmU9T5WIjJTHOAo3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric W Anderson <Eric.Anderson@colorado.edu>,
	linux-rt-users@vger.kernel.org
To: Xianghua Xiao <xiaoxianghua@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:52269 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab0FJCZ0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jun 2010 22:25:26 -0400
Received: by pzk6 with SMTP id 6so3360174pzk.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2010 19:25:26 -0700 (PDT)
In-Reply-To: <AANLkTindPmnb9Ct6G36drF-FrV8OmU9T5WIjJTHOAo3a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-06-09 at 13:50 -0500, Xianghua Xiao wrote:

> while upgrading to newer kernel sounds great, which I just did(from
> 2.6.18rt to 2.6.33rt), the newer kernel sometimes does not perform as
> well as older ones(plus it's also bloated), esp in embedded products.
> In my case, we got a slower product with the newer kernel, the 'worse'
> performance happened immediately when CFS was added. Even after a long
> time debugging and tweaking, it's still there.
> 
> xianghua

I am sure if you provided some specific code or performance data to
substantiate that regression someone here (or on LKML) would take
interest.

Regards

Sven

