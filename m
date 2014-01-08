From: =?iso-8859-1?Q?Sami_Pietik=E4inen?= <Sami.Pietikainen@wapice.com>
Subject: RE: [PATCH RT] add missing local serialization in ip_output.c
Date: Wed, 8 Jan 2014 07:11:08 +0000
Message-ID: <EBD2DE4ADA47B94E831AED12A4B0CADA844B1E58@edb0.wapice.localdomain>
References: <20131229171154.GA23586@opentech.at>
 <C9F8415089354E4FB76F4548B3515AF476ADD75F@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>
To: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wapice.fi ([81.209.51.2]:36561 "EHLO brando.wapice.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750790AbaAHHLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Jan 2014 02:11:10 -0500
In-Reply-To: <C9F8415089354E4FB76F4548B3515AF476ADD75F@edb1.wapice.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Patch also tested overnight with the Atmel SAMA5D35 evaluation board using
the same setup that originally produced the oops. No problems whatsoever.

BR,
Sami
