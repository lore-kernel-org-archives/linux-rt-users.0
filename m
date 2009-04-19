From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: Subject: PATCH : offline scheduler ( some refer to it as a CPU
	isolation )
Date: Sun, 19 Apr 2009 03:23:50 +0200
Message-ID: <c384c5ea0904181823m42a180d7p34d57ad8212ccc54@mail.gmail.com>
References: <1240081024.3534.3.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: raz ben yehuda <raziebe@013.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:12189 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbZDSBXw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 18 Apr 2009 21:23:52 -0400
Received: by yx-out-2324.google.com with SMTP id 3so461342yxj.1
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Apr 2009 18:23:51 -0700 (PDT)
In-Reply-To: <1240081024.3534.3.camel@raz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Raz,

On Sat, Apr 18, 2009 at 8:57 PM, raz ben yehuda <raziebe@013.net> wrote:
> offsched is a platform aimed to assign a service to an off-lined processor.
> Motivation is explained in:
> http://sos-linux.svn.sourceforge.net/viewvc/sos-linux/offsched/trunk/Documentation/OFFSCHED.pdf

I quickly glanced over but could not find a comparison with other methods?


Suppose I run /bin/init with a certain CPU affinity (not covering all
CPUs) and then run my own specific service on the remaining CPUs, how
would this differ from your approach?

>From what I quickly gathered, you are running parts of the kernel
space on the second CPU set, or is that too simple a statement?


Looks like a very fresh approach, nice project!

Regards,
-- 
Leon
