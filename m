From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 25 Aug 2009 13:22:40 -0600
Message-ID: <4A943A00.9080609@nortel.com>
References: <1250983671.5688.21.camel@raz>	 <1251004897.7043.70.camel@marge.simson.net> <1251018551.3810.35.camel@raz>	 <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz>	 <1251021133.14003.172.camel@marge.simson.net>	 <alpine.DEB.1.10.0908251122020.26329@gentwo.org>	 <1251222993.7023.53.camel@marge.simson.net>	 <alpine.DEB.1.10.0908251402300.17963@gentwo.org> <1251227322.7538.1172.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux-foundation.org>,
	Mike Galbraith <efault@gmx.de>,
	raz ben yehuda <raziebe@gmail.com>, riel@redhat.com,
	mingo@elte.hu, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zrtps0kp.nortel.com ([47.140.192.56]:57140 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbZHYTXH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Aug 2009 15:23:07 -0400
In-Reply-To: <1251227322.7538.1172.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/25/2009 01:08 PM, Peter Zijlstra wrote:

> Christoph, stop being silly, this offline scheduler thing won't happen,
> full stop.
> 
> Its not a maintainable solution, it doesn't integrate with existing
> kernel infrastructure, and its plain ugly.
> 
> If you want something work within Linux, don't build kernels in kernels
> or other such ugly hacks.

Is it the whole concept of isolating one or more cpus from all normal
kernel tasks that you don't like, or just this particular implementation?

I ask because I know of at least one project that would have used this
capability had it been available.  As it stands they have to live with
the usual kernel threads running on the cpu that they're trying to
dedicate to their app.

Chris
