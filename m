Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832D389E05
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2026 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.206.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535591; cv=none; b=GpOlle83llC3PXb9MBl4jsZNAncmctNhesxjNEs0ExfojLnvmA8gCVBlxz57KnYEtLLdmnPaOvvjceV+HjRFSFbnyuyOzxF/1RkZxyJt5dTBOQBRYqqKTu7bPDI3PutwYoH1nYCJ+bTwx4Z2OaLtBywzjptvGSjw86c86LG3+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535591; c=relaxed/simple;
	bh=1TbgDM5VXyNQguZLFZRezxvduvgvJewKkA24GXf388U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dlk7AQTu+1sV3GylZgBPnUzJPXrAzRul1+Tq73MEYITWmE+wNPcBVY8u8SBU6xIqqduswKFFyfXQCDhpxrd/mOsshOY7ik/+kllGxTv52JbQX1PPPecSyd7WEURgi33XsnYQkLEuELIAD2MrlBLjfl3dKzayVkVLl/BkbviCOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de; spf=pass smtp.mailfrom=sleepmap.de; dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b=FhsHwL/T; arc=none smtp.client-ip=85.10.206.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b="FhsHwL/T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sleepmap.de;
	s=RzV2MS86Cdvz; t=1784535259;
	bh=1TbgDM5VXyNQguZLFZRezxvduvgvJewKkA24GXf388U=;
	h=Date:From:To:Subject;
	b=FhsHwL/TEGk5Ta1AHQtGiY06V7N/R0/090TnxrAurpTnYTUALil9tyOdvwR5JrlXR
	 9OYTa47x9CMStbaZdZtJmz0nPEcoMUh/tQiGo5tHchUw/nSuSo1PCkFobTfBl0lv3a
	 F9X61C4niUoHCWxcKKUwnMsZa3uZMffTzp1QTgtE=
Date: Mon, 20 Jul 2026 10:14:02 +0200
From: David Runge <dave@sleepmap.de>
To: linux-rt-users@vger.kernel.org
Subject: Issues building RT patchset v6.18.13-rt4-rebase on top of v6.18.39
Message-ID: <al3YymTiIicX2Vin@hmbx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XFKz5FOPetns2YGr"
Content-Disposition: inline

--XFKz5FOPetns2YGr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:14:02 +0200
From: David Runge <dave@sleepmap.de>
To: linux-rt-users@vger.kernel.org
Subject: Issues building RT patchset v6.18.13-rt4-rebase on top of v6.18.39

Hi,

on Arch Linux we have switched to a rebase workflow to offer the linux-rt [=
1]
and linux-rt-lts [2] kernels on latest kernels of the series, so that we can
also apply security and regression fixes.

For linux-rt-lts and with rebasing v6.18.13-rt4-rebase [3] onto v6.18.39 (a=
nd
later on applying our own distribution patches) [4], we run into a build fa=
ilure
though.
(The rebase applied cleanly).

```
  CC [M]  drivers/misc/cardreader/rts5249.o
drivers/tty/serial/8250/8250_port.c:3225:7: error: conflicting types for =
=E2=80=98serial8250_fifo_wait_for_lsr_thre=E2=80=99; have =E2=80=98void(str=
uct uart_8250_port *, struct nbcon_write_context *, unsigned int)=E2=80=99
 3225 |  void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/tty/serial/8250/8250_port.c:40:
drivers/tty/serial/8250/8250.h:189:6: note: previous declaration of =E2=80=
=98serial8250_fifo_wait_for_lsr_thre=E2=80=99 with type =E2=80=98void(struc=
t uart_8250_port *, unsigned int)=E2=80=99
  189 | void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, u=
nsigned int count);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/linkage.h:7,
                 from ./include/linux/printk.h:8,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:108,
                 from ./arch/x86/include/asm/alternative.h:9,
                 from ./arch/x86/include/asm/barrier.h:5,
                 from ./include/linux/list.h:11,
                 from ./include/linux/module.h:12,
                 from drivers/tty/serial/8250/8250_port.c:14:
drivers/tty/serial/8250/8250_port.c:3245:22: error: conflicting types for =
=E2=80=98serial8250_fifo_wait_for_lsr_thre=E2=80=99; have =E2=80=98void(str=
uct uart_8250_port *, struct nbcon_write_context *, unsigned int)=E2=80=99
 3245 | EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_825=
0");
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=2E/include/linux/export.h:76:28: note: in definition of macro =E2=80=98__E=
XPORT_SYMBOL=E2=80=99
   76 |         extern typeof(sym) sym;                                 \
      |                            ^~~
drivers/tty/serial/8250/8250_port.c:3245:1: note: in expansion of macro =E2=
=80=98EXPORT_SYMBOL_NS_GPL=E2=80=99
 3245 | EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_825=
0");
      | ^~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/8250/8250.h:189:6: note: previous declaration of =E2=80=
=98serial8250_fifo_wait_for_lsr_thre=E2=80=99 with type =E2=80=98void(struc=
t uart_8250_port *, unsigned int)=E2=80=99
  189 | void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, u=
nsigned int count);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:287: drivers/tty/serial/8250/8250_port=
=2Eo] Error 1
make[5]: *** [scripts/Makefile.build:544: drivers/tty/serial/8250] Error 2
make[4]: *** [scripts/Makefile.build:544: drivers/tty/serial] Error 2
make[3]: *** [scripts/Makefile.build:544: drivers/tty] Error 2
make[3]: *** Waiting for unfinished jobs....
```

The culprit appears to be this commit:
'Reapply "serial: 8250: Switch to nbcon console"' [5]

I'm not sure who is currently working on the patchset for the 6.18 LTS bran=
ch,
but I guess it is worth exploring to drop/adjust the commit and release a n=
ew
patchset?
Is the patch still needed?

Best,
David

[1] https://archlinux.org/packages/extra/x86_64/linux-rt/
[2] https://archlinux.org/packages/extra/x86_64/linux-rt-lts/
[3] https://gitlab.archlinux.org/archlinux/packaging/upstream/linux-rt-lts/=
-/commits/v6.18.13-rt4-rebase
[4] https://gitlab.archlinux.org/archlinux/packaging/upstream/linux-rt-lts/=
-/commits/v6.18.39-rt4-arch1
[5] https://gitlab.archlinux.org/archlinux/packaging/upstream/linux-rt-lts/=
-/commit/c5661d54576a9bf12c2fd0eaa2a54baf48e45d4a
[6] https://wiki.linuxfoundation.org/realtime/start

--XFKz5FOPetns2YGr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR8efy7g3Ll3lsX4JqQ1LlkHgkpcQUCal3YygAKCRCQ1LlkHgkp
cdM0AP9i/2Ouw+nhN2hlFH+nyCz5lsmjEr6HebzE0V+GLF0BYQD/UnS2Da03x57z
GcidV71UPgVtkP3S2PtvC/zNa/aFcwk=
=TphY
-----END PGP SIGNATURE-----

--XFKz5FOPetns2YGr--
