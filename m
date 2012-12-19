From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Real-time kernel thread performance and optimization
Date: Wed, 19 Dec 2012 16:20:58 +0100
Message-ID: <50D1DB5A.7070708@osadl.org>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com> <50BCB40E.9050304@osadl.org> <alpine.LFD.2.02.1212191559180.4850@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: frank.rowand@am.sony.com, Simon Falsig <simon@newtec.dk>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:45682 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab2LSPcR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 10:32:17 -0500
In-Reply-To: <alpine.LFD.2.02.1212191559180.4850@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

>> [..]
>> If running a half-decent version of cyclictest, sleep states are generally
>> disabled while cyclictest is running. Please watch the line
>>    # /dev/cpu_dma_latency set to 0us
>> which essentially documents this mechanism. Yes, the name of the variable
>> "cpu_dma_latency" is not obvious and cyclictest could do a better job by
>> writing
>>    Wrote 0 to /dev/cpu_dma_latency and keeping the path open to prevent
>>    all cores from entering any sleep state
>> but this is another story.
> Not sure what you mean here, doesn't it keep the path open?
No, no, cyclictest does the right thing and keeps the path open as 
required. This is all good.

The message "/dev/cpu_dma_latency set to 0us" apparently is not clear 
enough. It has nothing to do with DMA but the purpose of setting the 
kernel variable cpu_dma_latency to 0 is to generally disable sleep 
states. But I better should have submitted a patch.

	-Carsten.
