From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Fri, 23 Sep 2016 18:17:29 +0200
Message-ID: <20160923161729.dorliryuc2f6qwne@linutronix.de>
References: <1474532371.10922.50.camel@denx.de>
 <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
 <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
 <1474553779.10922.87.camel@denx.de>
 <20160922144122.ywq7p27fcxlplo6d@linutronix.de>
 <ea685403-9c42-95ce-9528-3dce338a98d7@siemens.com>
 <20160923160017.fiajrhsyzhvgi6hz@linutronix.de>
 <070f63d3-b13d-48ab-fe1b-96168b527bd3@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Claudius Heine <ch@denx.de>, linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbcIWQRf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 12:17:35 -0400
Content-Disposition: inline
In-Reply-To: <070f63d3-b13d-48ab-fe1b-96168b527bd3@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-23 18:12:02 [+0200], Jan Kiszka wrote:
> I was also trying to turn MSI on in intel_quark_i2c_gpio, but that
> device fired back by stopping to deliver interrupts. OK.

you could also take a week off and talk to the BIOS developer.

> Jan

Sebastian
