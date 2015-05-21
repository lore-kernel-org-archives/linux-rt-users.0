From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH] cyclictest: remove compatibilty hack for old libnuma,
 repairs "-a" for isolcpus
Date: Thu, 21 May 2015 16:19:19 +0200
Message-ID: <20150521161919.0d8d2278@md1em3qc>
References: <20150427125846.1de46037@sluggy>
	<1432126711-18618-1-git-send-email-henning.schild@siemens.com>
	<alpine.LFD.2.10.1505201629400.7867@riemann>
	<20150521131119.4909a2dd@md1em3qc>
	<1432211005.5810.29.camel@eagleseven.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"gary.robertson@linaro.org" <gary.robertson@linaro.org>,
	"williams@redhat.com" <williams@redhat.com>
To: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:33498 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649AbbEUOTQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 10:19:16 -0400
In-Reply-To: <1432211005.5810.29.camel@eagleseven.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 May 2015 12:23:25 +0000
Staffan Tjernstrom <stjernstrom@eagleseven.com> wrote:

> Then again, CentOS 5 (and other variants of that ilk) is under
> official support until early 2017[1], and it uses 0.9.8[2]

The problem only appears >=2.0 && <2.0.9.

Henning
