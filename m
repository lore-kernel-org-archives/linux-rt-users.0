From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 16:13:28 +0200
Message-ID: <1185372808.23485.2.camel@godzilla.tecnorama.it>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>
	 <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu>
	 <46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr>
	 <20070725130536.GA12334@elte.hu> <46A74E05.50504@free.fr>
	 <20070725133835.GA17616@elte.hu>  <46A758B5.9070602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:46144 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024AbXGYONd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 10:13:33 -0400
In-Reply-To: <46A758B5.9070602@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi John,

On Wed, 2007-07-25 at 16:05 +0200, John Sigler wrote:
[...] 
> # cat /proc/interrupts
>             CPU0
>    0:         37    XT-PIC-XT        timer

Just curious: Can you post the output of the "cat /proc/timer_list" ?
Thanks.

Ciao,
Alessio
