From: Giuliano Colla <giuliano.colla@fastwebnet.it>
Subject: RT_PREEMPT on Raspberry PI 3
Date: Sun, 18 Sep 2016 12:03:42 +0200
Message-ID: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mr005msr.fastwebnet.it ([85.18.95.68]:44788 "EHLO
        mr005msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755670AbcIRKJF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Sep 2016 06:09:05 -0400
Received: from probookcolla.localdomain (2.224.139.229) by mr005msr.fastwebnet.it (8.5.140.05) (authenticated as giuliano.colla@fastwebnet.it)
        id 57D6D1BC0051BC49 for linux-rt-users@vger.kernel.org; Sun, 18 Sep 2016 12:03:43 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,

I'm developing industrial applications requiring real-time performance 
on a Raspberry pi3 platform.

I have managed to achieve both good performance and good stability, but 
I have been obliged to overcome some difficulties which IMHO could have 
been avoided if the Raspberry platform peculiarities had been given more 
attention. Being a very popular platform, particularly suited also for 
real-time applications, I believe it deserves it.

The main items are:

1) The RT patches are not in sync with mainline Raspbian kernel 
versions. At the time of writing, the stock 4.x kernel supported is 
4.4.21, while the last available patch is 4.4.19-rt27. Even going 
backwards it's impossible to find a perfect match: 4.4.14 against 
4.4.12-rt20 or 4.4.15-rt23, and so on.

I'm currently using a 4.4.13 kernel with a 4.4.12-rt19 patch, which was 
the best match I could find, and which required some minor manual 
adjustments.

Is there a way to provide a better sync?

2) The RT_PREEMPT patch is not compatible with FIQ (or maybe FIQ is not 
compatible with RT_PREEMPT). Leaving FIQ enabled generates intolerably 
frequent freezes. It appears to work properly only on the basic 
Raspberry pi (single core) but not on the multicore Pi2 and Pi3. 
Currently the only way to make a real-time kernel run on Raspberry PI 2 
or 3 is to disable FIQ on the command line.

If the RT_PREEMPT patch could somehow support this incompatibility 
(either by fully disabling FIQ or fixing the code) this would be a great 
help, thus avoiding populating forums with "my raspberry pi2/3 freezes 
with rt patch"

Can something be done to solve those issues?

Thanks,

Giuliano


