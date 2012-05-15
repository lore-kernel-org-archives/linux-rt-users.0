From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] compile fix for brcm80211 on v3.2.17
Date: Tue, 15 May 2012 15:22:14 -0400
Message-ID: <1337109734.14207.348.camel@gandalf.stny.rr.com>
References: <20120515140413.04c19fad@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Ben Hutchings <ben@decadent.org.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Arend van Spriel <arend@broadcom.com>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	BrettRudley <brudley@broadcom.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Roland Vossen <rvossen@broadcom.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2383 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966529Ab2EOTWR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 15:22:17 -0400
In-Reply-To: <20120515140413.04c19fad@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-15 at 14:04 -0500, Clark Williams wrote:
> Ben,
> 
> Found this while building v3.2.17-rt28:
> 
> diff --git a/drivers/net/wireless/brcm80211/brcmsmac/main.c b/drivers/net/wireless/brcm80211/brcmsmac/main.c
> index f98becc..833cbef 100644
> --- a/drivers/net/wireless/brcm80211/brcmsmac/main.c
> +++ b/drivers/net/wireless/brcm80211/brcmsmac/main.c
> @@ -7879,7 +7879,7 @@ brcms_c_recvctl(struct brcms_c_info *wlc, struct d11rxhdr *rxh,
>         if (wlc->hw->suspended_fifos) {
>                 hdr = (struct ieee80211_hdr *)p->data;
>                 if (ieee80211_is_beacon(hdr->frame_control))
> -                       brcms_b_mute(wlc->hw, false);
> +                       brcms_b_mute(wlc->hw, false, 0);
>         }
>  
>         memcpy(IEEE80211_SKB_RXCB(p), &rx_status, sizeof(rx_status));
> 
> Not sure if that's completely correct but I found another call site for
> brcms_b_mute() that also passed 0 flags. 

The bug was caused by this patch:

commit d609909f0d6c69937057237b3eff577311d08d07
Author: Arend van Spriel <arend@broadcom.com>
brcm80211: smac: resume transmit fifo upon receiving frames

(mainline: badc4f07622f0f7093a201638f45e85765f1b5e4)

Because it was added to mainline after this patch:

commit c6c44893c864429a7c6a4f7942dfb3ee182b4ad1
Author: Roland Vossen <rvossen@broadcom.com>
brcm80211: smac: fixed inconsistency in transmit mute

Which converted brcms_b_mute() from 3 arguments to 2.

-- Steve



