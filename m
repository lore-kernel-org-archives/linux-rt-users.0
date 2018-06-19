Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:57667 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeFSQ0f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Jun 2018 12:26:35 -0400
Date: Tue, 19 Jun 2018 18:26:33 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT Patch and Xen
Message-ID: <20180619162633.26pmgstzxjgmbdlo@linutronix.de>
References: <CALC81-sg=86AZgZv4bGSNPJEmw3r_j=yNv5HuGPBWKMYVoXJ1A@mail.gmail.com>
 <20180507131505.tv6qz4rzvya5o3no@linutronix.de>
 <CALC81-uM_23mu-EGhGSrW=-yUpZh+f_-hQQ=7Xa1Ka3mKygObQ@mail.gmail.com>
 <20180515140313.6u777gfafpthsijj@linutronix.de>
 <CALC81-sqTxZwUvXb1ofFcREkU_xJYA_VYfeu++GroUG_ca8dUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALC81-sqTxZwUvXb1ofFcREkU_xJYA_VYfeu++GroUG_ca8dUw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Iain Hunter <drhunter95@gmail.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-06-19 17:19:59 [+0100], Iain Hunter wrote:
> Hi Sebastian,
Hi Iain,

> I have now tested dropping the restriction on Xilinx 4.14 with rt1 and
> mainline 4.16.15-rt6. With both of these I can successfully run a Xen
> Guest domain (DomU) with at least networking available (scp and ssh
> works).

so if it works and there are no more "sleeping while atomic" warnings
nor does lockdep complain then feel free to send a patch to remove this
restriction.

> Iain

Sebastian
