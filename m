From: jordan johnston <triplesquarednine@gmail.com>
Subject: Re: 2.6.35 RT support roadmap
Date: Thu, 12 Aug 2010 23:17:05 -0400
Message-ID: <AANLkTikoUbL4Q8PNia38AByEfTY56Bqr5uVnyyNxvS1W@mail.gmail.com>
References: <CD8FEF6F82F55744AA1ED2BE5E7D8FD2015184EE0B@dnce01.ent.ti.com>
	<AANLkTimmCqNz+ZhSCqMGhaiCmW38hnjfkLV0ZU+e2gkX@mail.gmail.com>
	<1281638311.7093.4.camel@marge.simson.net>
	<4C645567.2080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Galbraith <efault@gmx.de>,
	Xianghua Xiao <xiaoxianghua@gmail.com>,
	"Walzer, Frank" <f-walzer@ti.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33734 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab0HMDRG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Aug 2010 23:17:06 -0400
Received: by eya25 with SMTP id 25so1035842eya.19
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Aug 2010 20:17:05 -0700 (PDT)
In-Reply-To: <4C645567.2080308@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Google did Android and even Palm woke up (just long enough to watch its own
> demise).
>
> The rest is history.
>
> Except of course putting the RT Kernel in Android.

As i understand it, many Android users are using the BFS patchset, and
have been for a while. BFS pretty much does what "the end result of
using the rt-patches" accomplish, minus rtirq, spin-locks, etc. You
will get the desired
responsiveness that using RT would give you.

Im pretty sure that is why Zen-kernel has a git repository "very
specifically" for android (BFS is the default kernel setting). I'm
sure there are other goodies for android in there too.

www.zen-kernel.org

I don't know much about the Android repo's state (as it's fairly new).
but worth a
look for your "rt-usage" (ie. performance/responsiveness) for android.
 As i do not own an Android, i have not tested it, but i have talked
with people who do..

I'm waiting to see what 2.6.35 holds for RT.... but personally i am
using BFS and 2.6.34 with a lot of performance tuning (a good deal of
time spent analyzing/tuning) and i am yielding better results not
using the upstream rt-patches.
we will see what happens in 2.6.35/36....

just my 2 cents :)

cheers

jordan
