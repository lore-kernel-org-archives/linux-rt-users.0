From: Stanislav Meduna <stano@meduna.org>
Subject: Re: w1-gpio: sleeping function called from invalid context
Date: Wed, 16 Apr 2014 21:58:48 +0200
Message-ID: <0e38dfcf-df54-4b72-abf1-9b424af3f98b@email.android.com>
References: <534E97C8.5090407@meduna.org> <534ED833.6020303@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: Paul Gortmaker <paul.gortmaker@windriver.com>, zbr@ioremap.net,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:55772 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaDPUAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Apr 2014 16:00:16 -0400
In-Reply-To: <534ED833.6020303@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On April 16, 2014 9:21:23 PM CEST, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

>  static int w1_disable_irqs = 0;
>  module_param_named(disable_irqs, w1_disable_irqs, int, 0);
...
>I've no idea why that module parameter exists.  Why do you set it?

Hm... I do not, at least not knowingly. I'll try to trace what exactly happens.

Thanks
-- 
                                     Stano
