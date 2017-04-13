From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Timeline or 4.9 RT Stable?
Date: Thu, 13 Apr 2017 16:59:34 +0200
Message-ID: <20170413145934.3d32xmnylffaqi3v@linutronix.de>
References: <D5D6254030DBC644B6EE58B333BFBB1E9C1BFC18@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Hindman, Gavin" <gavin.hindman@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38424 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdDMO7g (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Apr 2017 10:59:36 -0400
Content-Disposition: inline
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1E9C1BFC18@ORSMSX112.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-04-11 16:10:23 [+0000], Hindman, Gavin wrote:
> Hello Everyone,
Hi Gavin,

> 4.9 LTS has been out for some time, now.  Is there an anticipated timeline for a 4.9 RT-Stable patch set?

I am not sure if I answer your question with this:
v4.9-RT patch is set around. The usual workflow is to move the devel-RT
tree (which is what v4.9-RT is now) to stable maintenance once we move a
newer RT tree (newer major version).

> Thanks,
> Gavin Hindman

Sebastian
