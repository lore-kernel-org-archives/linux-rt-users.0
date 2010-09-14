From: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: RE: preempt rt in commercial use
Date: Tue, 14 Sep 2010 06:37:57 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE1099C8AEC@tranzeo-mail2.12stewart.tranzeo.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com><201009141317.13439@zigzag.lvk.cs.msu.su><AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com><20100914094411.GB10841@pengutronix.de><4C8F67A6.1030409@steinhoff.de> <87d3sglb1c.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.tranzeo.com ([64.114.87.10]:18370 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab0INNh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 09:37:58 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87d3sglb1c.fsf@lola.goethe.zz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have used RT preemption to ensure that WiMAX radio PHY and MAC drivers
can be appropriately prioritized to avoid hardware I/O overun and
underrun conditions.

Like some have mentioned, trying to maintain this essential stability
simultaneous with high throughput (especially high bandwidth stream of
really small packets) can still be a challenge.

Regards,

Darcy
