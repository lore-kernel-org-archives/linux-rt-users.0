From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Thu, 14 May 2015 18:07:33 +0200
Message-ID: <20150514160733.GE13442@linutronix.de>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
 <20150506193803.GC32577@8074w.roxell.se>
 <CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com>
 <20150508000929.GE31914@8074w.roxell.se>
 <CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anders Roxell <anders.roxell@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Kevin Hilman <kevin.hilman@linaro.org>
To: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38124 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbbENQHg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 12:07:36 -0400
Content-Disposition: inline
In-Reply-To: <CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Ayyappa Ch | 2015-05-11 11:02:56 [+0530]:

>Hello Anders Roxell,
>
>Many thanks for your inputs.
>
>But as per my observation after this change , Cyclic test did not failed.
>
>As logs are huge size , sent only to you.
>
>Can you please check the logs and let us know your view ?

fpsimd_save_state() is almost the fpsimd_save macro which saves 32
16byte registers. And *this* takes really that long? You max says 100116
which means 100ms.

>Thanks and regards,
>Ayyappa.Ch

Sebastian
