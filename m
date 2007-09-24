From: "Cliff Brake" <cliff.brake@gmail.com>
Subject: Re: Priority of serial driver
Date: Mon, 24 Sep 2007 11:45:22 -0400
Message-ID: <f96d234e0709240845t2c00a728u84f2fd4b58690aaf@mail.gmail.com>
References: <f96d234e0709221122g36dab213y41645c159d620c8e@mail.gmail.com>
	 <20070922191522.GA4887@ghostprotocols.net>
	 <f96d234e0709240750h6d96f80ev87da3bfde185b6ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:40562 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbXIXPpZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Sep 2007 11:45:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1441350rvb
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Sep 2007 08:45:22 -0700 (PDT)
In-Reply-To: <f96d234e0709240750h6d96f80ev87da3bfde185b6ff@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9/24/07, Cliff Brake <cliff.brake@gmail.com> wrote:
> On 9/22/07, Arnaldo Carvalho de Melo <acme@ghostprotocols.net> wrote:
> > Look at the IRQ-<N> kernel thread that services the serial port hardware
> > interrupt, use chrt to bump its priority and see if it helps.
>
> I don't see any IRQ-<N> processes on my system -- does this require
> the RT patch?  Perhaps this is different on ARM/x86?

I've applied the RT patch which gives me the IRQ-N processes -- trying now ...

Cliff
