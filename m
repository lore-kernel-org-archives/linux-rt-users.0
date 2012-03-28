From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Determining latest stable release.
Date: Thu, 29 Mar 2012 00:08:31 +0200
Message-ID: <4F738BDF.8080904@osadl.org>
References: <CAOHJ0jTVxzgfBK=GSEr14YrpFZEqFE_qDqftaUgGWDgm344NNg@mail.gmail.com>	<CAOHJ0jQphT30v-y1HMiHYOnFVumovkccCV43mDJjBx=fko=GUg@mail.gmail.com>	<20120328140022.2998bfbc@redhat.com>	<op.wbwdrtr2uqv2j3@woifes-laptop> <20120328153450.52c62ab8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Wallner <wolfgang-wallner@gmx.at>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:37432 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758817Ab2C1Wu2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Mar 2012 18:50:28 -0400
In-Reply-To: <20120328153450.52c62ab8@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/28/2012 10:34 PM, Clark Williams wrote:
> On Wed, 28 Mar 2012 22:27:19 +0200
> "Wolfgang Wallner"<wolfgang-wallner@gmx.at>  wrote:
>> What is the relation between these stable releases and what the OSADL
>> calls 'latest stable'?
>> [..]
>> https://www.osadl.org/Latest-Stable-Realtime.latest-stable-realtime-linux.0.html
>> On Wed, 28 Mar 2012 21:00:22 +0200, Clark Williams<williams@redhat.com>
>> wrote:
>> [..]
>>> The stuff that Steven releases is the stable series, while Thomas
>>> does the devel releases. So if you're not looking for the latest and
>>> greatest, I'd stick to what Steven releases.
> I think we'll have to ask Carsten about his stable release criteria. It
> may be that he's being more conservative than us and staying on a 2.6
> kernel.
Yes, indeed. We made the (probably naive) promise to not label a kernel
version "Latest Stable", unless there are no known bugs or regressions. 
This means that all our development systems in the QA Farm must be 
running this kernel for at least a month under all appropriate load 
scenarios without any problem. Please note that some of the load 
conditions have been introduced only recently, so it may be harder than 
ever for a kernel to pass these tests. But we need these benchmarks in 
order to reliably discover performance regressions. In addition, with 
the increasing use of Linux in safety-critical systems we need to 
provide a stable software basis on top of which additional tests and 
procedures can be built.

Many of the pending problems of the RT versions of the 3.0 and the 3.2 
kernel have been solved recently, and we now are very close to label one 
of the 3.x kernels (probably 3.2) "Latest stable". The most important 
problem that really needs to be solved before we even can thing to go 
"Latest Stable" are crashes of unknown origin during heavy file I/O. 
Only relatively slow and mostly single-core systems are affected. Since 
the systems simply stop without any output, our progress with this issue 
is very slow.

Except this and another regression that may not be important for the 
majority of RT users, the 3.x RT kernel is pretty stable and has 
impressive real-time capabilities. Such systems, if thoroughly tested, 
certainly may be used in a productive environment. However, the extra 
guarantee and confidence levels of an OSADL "Latest Stable" kernel 
unfortunately are not yet available.

Hope this helps.
	-Carsten.
