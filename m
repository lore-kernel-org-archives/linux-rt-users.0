Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:55209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeCPKaL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Mar 2018 06:30:11 -0400
Date: Fri, 16 Mar 2018 11:30:09 +0100
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: inconsistent lock state on v4.14.20-rt17
Message-ID: <20180316103009.6cwjctghuoellcua@linutronix.de>
References: <1520350053.1744.6.camel@ginzinger.com>
 <20180306182154.nkia5hl4r3r2ncru@linutronix.de>
 <1520411200.1744.11.camel@ginzinger.com>
 <20180308155741.vbdqprs6stx5zu4q@linutronix.de>
 <1520530739.1744.18.camel@ginzinger.com>
 <20180308180025.zdhu3zl24zfkb3qz@linutronix.de>
 <1520588836.1921.2.camel@ginzinger.com>
 <20180314195523.5ndigtyecugodzmg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180314195523.5ndigtyecugodzmg@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-03-14 20:55:24 [+0100], To Roosen Henri wrote:
> This survived 6 days. It was challenging to cancel hackbench because it
> was running via ssh in a screen session and I was loosing my network
> connection due to inactivity…

okay. It may have survived but it managed to trigger this. Trying to
make sense to this…

> > Thanks,
> > Henri

Sebastian
