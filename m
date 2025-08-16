Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC2233145;
	Sat, 16 Aug 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344508; cv=none; b=RGk5pFf/wplH8WwUkEqzvc2+7H7mpwhxBtllAKPvKZfVVsOk1FhTet6ImYJ515LkTt7t81J3aYpPDCv0J2MKY5lfGBxQIGk3BKoZbyApH3JfgSvTTDU0crts97TsinqjeyHY5oU+Boq4JutE3NXAkBWWdOsiwNVCoWvuILQkHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344508; c=relaxed/simple;
	bh=hlZiv6i0izj59JPrw9wAti+8PgrPRPX5oLa43RUW6m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwLFUBa44oqLuWo8911BTfxS5q45wh8zJ1jeVmWBupuD13wnvxuIrVx1CZ6vXHivX68tvJCzrshmvBvXey96rOIiInnc8ox+bUyDOyEfcLSZjrQGIjk42VoB5wq/VKOSca4xLMNVajKB1f7aZE1QiWqus0wcEQ4HFQgs1/0FDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174b335bso413372a12.2;
        Sat, 16 Aug 2025 04:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755344505; x=1755949305;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWlDjA1sXFHXdAgp16yAc0EYJW8Eh5MuvND9wlLFgYI=;
        b=i89jMWy/4ZKHnvudwzfIiraOOkz7grR2Q/Y/TmRiGndM/0JnsgUAnrmRi1UkxWxiSO
         UpZzSEomDCvQpcFwcZBqNFpp+jBP+cFk7ANsC9iGd7DR5p8749/E73Fb3bMNbQkuXvla
         Ndin1kNXNu3QCGVPF2EkWC9wrbNka5mUAOGOM+KgyOH/J6U870V5CPggDFSPMH7LK9Hv
         ZfYetigW7PWVYS2Q9lxAjAmDVil2RC36AbrfvMockV7WYXGAIVb0acbMJ38EQrUhZ1jZ
         hb+gQU2JGcEsPlxlnsuGeyzAVG9jdzNurJtZJ4zYuLPCpmtkXycN25IvbgSv1zDQUNPI
         LDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvum982cEujtFUYAlCUoDDnVBGerCoGzRoRKZwIs2uxktSAzH+SasRIvWmW8YIr2+QQIN9nGT/cuF@vger.kernel.org, AJvYcCUsC106LjdfQRK9xxLNxHNfG2Kbs5uAusBlqSj1/SDvHFF5YzwIOBeilaNxC8VnhTQuSVf49e2yBhHe1zg=@vger.kernel.org, AJvYcCXpGJzC0lLKXjHVn6ljyv5Q3li0GSPBoVrkq1t58PwdYFPwqzi0bhpIE/eHf8Qx7pL9zycdex7IfpJfmIqOhgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHPc+KX+4boHbK4QptuoF7zsp+Gy2fuEtMGkSf6FEereW6Tl5
	tBPtdQngBUP8Du+grUc71dYeFNGloTv6gYYlzXzcsOh9exqtfhAn7XfS
X-Gm-Gg: ASbGncs7mcIRKDzOWWsz2lIar3jVWfvwQObjWaDObWGOI3BW2z2x/Lzz4jt9VQAryx2
	SoFd/KQkI/7wUp81g2anc6mTSlSdfdrcQCHifH+VdQI1j9nXq+i3u0daAHkaX3NGWEngiHO9+LB
	r9lKqqWB0ZOA7clA+7aiduF6zaSGtXc99F8T+wUBANoeSsmBv+Yw8hHYUZyWpqMjtTP18NhIw2+
	OFvlinF+bGNj0wJ8PHHI3nIK0M2jOB/IJYd2YQ1pexKdltn10MINJm5XlYwNmrnnp1LTK1aVuG5
	ykUYK7duOKsOUSH3R4vQ8LLR3cFxA6cl710/K44Vl2g5wSYZ5vGM2E/I0NOyBwShrdh+qk4guqI
	S7QcybZ/a1nZFFci20h4uaShBWn4/gPhd
X-Google-Smtp-Source: AGHT+IGLTI+yWcATH8BCLEZeMs0e5MHA0yZ0JbTsQ7ENay0xt18bYnC9ukz1m2l19OqlIlkgivF+mg==
X-Received: by 2002:a17:902:c407:b0:240:3e72:ef98 with SMTP id d9443c01a7336-2446d9f7764mr39128255ad.10.1755344504488;
        Sat, 16 Aug 2025 04:41:44 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f56asm34295665ad.94.2025.08.16.04.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 04:41:44 -0700 (PDT)
Message-ID: <de63000c-f660-4df7-9fe6-05b7630bf64a@kzalloc.com>
Date: Sat, 16 Aug 2025 20:41:37 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] usb: gadget: dummy_hcd: Sleeping function called from
 invalid context in dummy_dequeue on PREEMPT_RT
To: Nam Cao <namcao@linutronix.de>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Marcello Sylvester Bauer <sylv@sylv.io>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Al Viro <viro@zeniv.linux.org.uk>, andreyknvl@gmail.com,
 Austin Kim <austindh.kim@gmail.com>, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <5b337389-73b9-4ee4-a83e-7e82bf5af87a@kzalloc.com>
 <20250816065933.EPwBJ0Sd@linutronix.de>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250816065933.EPwBJ0Sd@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you Nam,

On 8/16/25 3:59 PM, Nam Cao wrote:
> On Sat, Aug 16, 2025 at 11:38:14AM +0900, Yunseong Kim wrote:
>> While testing a PREEMPT_RT enabled kernel (based on v6.17.0-rc1),
>> I encountered a "BUG: sleeping function called from invalid context" e=
rror
>> originating from the dummy_dequeue function in the dummy USB driver.
> ...
>> The pattern of manually disabling IRQs and then taking a spinlock
>> local_irq_save() + spin_lock() is unsafe on PREEMPT_RT, the current co=
de
>> structure keeps IRQs disabled even after spin_unlock(&dum->lock) while=

>> calling usb_gadget_giveback_request(). This extended atomic context ca=
n
>> also be problematic if the completion handler attempts to acquire anot=
her
>> sleepable lock.
>=20
> I don't know the USB subsystem well, but the comments above struct
> usb_request says:
>=20
>  * @complete: Function called when request completes, so this request a=
nd
>  *	its buffer may be re-used.  The function will always be called with
>  *	interrupts disabled, and it must not sleep.
>=20
> Therefore it shouldn't be a concern that "completion handler attempts t=
o
> acquire another sleepable lock".
>=20
>> I request a review and correction of this locking mechanism to ensure
>> stability on PREEMPT_RT configurations.  Kernel config, full logs, and=

>> reproduction steps can be provided on request.
>=20
> This was introduced by b4dbda1a22d2 ("USB: dummy-hcd: disable interrupt=
s
> during req->complete") which split the spin_lock_irqsave() into
> local_irq_save() and spin_lock().
>=20
> The untested patch below should help?
>=20
> Enabling interrupt (spin_unlock_irqrestore) and then immediately disabl=
ing
> interrupt (local_irq_save) is not the nicest thing. But then I don't se=
e
> how to avoid that while being non-hacky and human-readable.
>=20
> Nam

Oh, I see! I=E2=80=99ll apply the patch and check if it reproduces the is=
sue.

> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/ud=
c/dummy_hcd.c
> index 21dbfb0b3bac..a4653c919664 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -765,8 +765,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct=
 usb_request *_req)
>  	if (!dum->driver)
>  		return -ESHUTDOWN;
> =20
> -	local_irq_save(flags);
> -	spin_lock(&dum->lock);
> +	spin_lock_irqsave(&dum->lock, flags);
>  	list_for_each_entry(iter, &ep->queue, queue) {
>  		if (&iter->req !=3D _req)
>  			continue;
> @@ -776,15 +775,16 @@ static int dummy_dequeue(struct usb_ep *_ep, stru=
ct usb_request *_req)
>  		retval =3D 0;
>  		break;
>  	}
> -	spin_unlock(&dum->lock);
> +	spin_unlock_irqrestore(&dum->lock, flags);
> =20
>  	if (retval =3D=3D 0) {
>  		dev_dbg(udc_dev(dum),
>  				"dequeued req %p from %s, len %d buf %p\n",
>  				req, _ep->name, _req->length, _req->buf);
> +		local_irq_save(flags);
>  		usb_gadget_giveback_request(_ep, _req);
> +		local_irq_restore(flags);
>  	}
> -	local_irq_restore(flags);
>  	return retval;
>  }
> =20

This is reproducer for syzlang:

r0 =3D syz_usb_connect(0x0, 0x24, &(0x7f0000000000)=3D{{0x12, 0x1, 0x0, 0=
x97, 0xff, 0x82, 0x8, 0x2058, 0x1005, 0xc19b, 0x0, 0x0, 0x0, 0x1, [{{0x9,=
 0x2, 0x12, 0x1, 0x0, 0x0, 0x0, 0x0, [{{0x9, 0x4, 0x8f, 0x0, 0x0, 0xbf, 0=
x57, 0x5a}}]}}]}}, 0x0)
syz_usb_control_io$cdc_ncm(r0, &(0x7f0000000100)=3D{0x14, &(0x7f000000004=
0)=3D{0x40, 0x0, 0x66, {0x66, 0x23, "6f2c18388112efffc4889080ab31f0d29845=
65049864502a1901c1114c7de30280e1de22288286cbc96de93149c64ba40c486c6d8618f=
867660d217efe65d204e4284c884ff6b3326cdc124b3c444b7897f53d604ca3ecf79ad0a1=
360b963987489ad1d1"}}, &(0x7f00000000c0)=3D{0x0, 0x3, 0x1a, {0x1a}}}, &(0=
x7f0000000400)=3D{0x44, &(0x7f0000000140)=3D{0x40, 0x6, 0xc9, "e839c62caa=
4b30555c01ce5505144112eb8d7923383a6acbd7b1071c0b04359674d10837182419a1be1=
791ea591049213cbcead05c73d3029f9d72863d816c862b8f48760664abc2bf72b5b9567a=
a1fc9b102137d0c8a2c4d89347359b0fd81f0f1ec8ad4eb16b5d8860175c6f22214831828=
eead648503705b5eb201243a6adea26451b3ef72e6326cf80d579773dc52b167dbb56efa4=
1ed5092b8b20904c8aa28bdba20aad3ac4859191490901edaa2a4b62452f9e84f219de47c=
767a852e96ed3c760c0431c3423"}, &(0x7f0000000240)=3D{0x0, 0xa, 0x1, 0x8}, =
&(0x7f0000000280)=3D{0x0, 0x8, 0x1, 0x9}, &(0x7f00000002c0)=3D{0x20, 0x80=
, 0x1c, {0x4b, 0x8, 0x8, 0x2, 0x7, 0xc373, 0x8, 0xe, 0x2, 0x80, 0x112, 0x=
4c}}, &(0x7f0000000300)=3D{0x20, 0x85, 0x4, 0x91f409a}, &(0x7f0000000340)=
=3D{0x20, 0x83, 0x2, 0x1}, &(0x7f0000000380)=3D{0x20, 0x87, 0x2, 0x9}, &(=
0x7f00000003c0)=3D{0x20, 0x89, 0x2, 0x1}})

This is reproducer for C:

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#include <linux/usb/ch9.h>

#ifndef __NR_mmap
#define __NR_mmap 222
#endif

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

#define MAX_FDS 30

#define USB_MAX_IFACE_NUM 4
#define USB_MAX_EP_NUM 32
#define USB_MAX_FDS 6

struct usb_endpoint_index {
  struct usb_endpoint_descriptor desc;
  int handle;
};

struct usb_iface_index {
  struct usb_interface_descriptor* iface;
  uint8_t bInterfaceNumber;
  uint8_t bAlternateSetting;
  uint8_t bInterfaceClass;
  struct usb_endpoint_index eps[USB_MAX_EP_NUM];
  int eps_num;
};

struct usb_device_index {
  struct usb_device_descriptor* dev;
  struct usb_config_descriptor* config;
  uint8_t bDeviceClass;
  uint8_t bMaxPower;
  int config_length;
  struct usb_iface_index ifaces[USB_MAX_IFACE_NUM];
  int ifaces_num;
  int iface_cur;
};

struct usb_info {
  int fd;
  struct usb_device_index index;
};

static struct usb_info usb_devices[USB_MAX_FDS];

static struct usb_device_index* lookup_usb_index(int fd)
{
  for (int i =3D 0; i < USB_MAX_FDS; i++) {
    if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) =3D=3D fd)
      return &usb_devices[i].index;
  }
  return NULL;
}

static int usb_devices_num;

static bool parse_usb_descriptor(const char* buffer, size_t length,
                                 struct usb_device_index* index)
{
  if (length < sizeof(*index->dev) + sizeof(*index->config))
    return false;
  memset(index, 0, sizeof(*index));
  index->dev =3D (struct usb_device_descriptor*)buffer;
  index->config =3D (struct usb_config_descriptor*)(buffer + sizeof(*inde=
x->dev));
  index->bDeviceClass =3D index->dev->bDeviceClass;
  index->bMaxPower =3D index->config->bMaxPower;
  index->config_length =3D length - sizeof(*index->dev);
  index->iface_cur =3D -1;
  size_t offset =3D 0;
  while (true) {
    if (offset + 1 >=3D length)
      break;
    uint8_t desc_length =3D buffer[offset];
    uint8_t desc_type =3D buffer[offset + 1];
    if (desc_length <=3D 2)
      break;
    if (offset + desc_length > length)
      break;
    if (desc_type =3D=3D USB_DT_INTERFACE &&
        index->ifaces_num < USB_MAX_IFACE_NUM) {
      struct usb_interface_descriptor* iface =3D
          (struct usb_interface_descriptor*)(buffer + offset);
      index->ifaces[index->ifaces_num].iface =3D iface;
      index->ifaces[index->ifaces_num].bInterfaceNumber =3D
          iface->bInterfaceNumber;
      index->ifaces[index->ifaces_num].bAlternateSetting =3D
          iface->bAlternateSetting;
      index->ifaces[index->ifaces_num].bInterfaceClass =3D iface->bInterf=
aceClass;
      index->ifaces_num++;
    }
    if (desc_type =3D=3D USB_DT_ENDPOINT && index->ifaces_num > 0) {
      struct usb_iface_index* iface =3D &index->ifaces[index->ifaces_num =
- 1];
      if (iface->eps_num < USB_MAX_EP_NUM) {
        memcpy(&iface->eps[iface->eps_num].desc, buffer + offset,
               sizeof(iface->eps[iface->eps_num].desc));
        iface->eps_num++;
      }
    }
    offset +=3D desc_length;
  }
  return true;
}

static struct usb_device_index* add_usb_index(int fd, const char* dev,
                                              size_t dev_len)
{
  int i =3D __atomic_fetch_add(&usb_devices_num, 1, __ATOMIC_RELAXED);
  if (i >=3D USB_MAX_FDS)
    return NULL;
  if (!parse_usb_descriptor(dev, dev_len, &usb_devices[i].index))
    return NULL;
  __atomic_store_n(&usb_devices[i].fd, fd, __ATOMIC_RELEASE);
  return &usb_devices[i].index;
}

struct vusb_connect_string_descriptor {
  uint32_t len;
  char* str;
} __attribute__((packed));

struct vusb_connect_descriptors {
  uint32_t qual_len;
  char* qual;
  uint32_t bos_len;
  char* bos;
  uint32_t strs_len;
  struct vusb_connect_string_descriptor strs[0];
} __attribute__((packed));

static const char default_string[] =3D {8, USB_DT_STRING, 's', 0, 'y', 0,=
 'z', 0};

static const char default_lang_id[] =3D {4, USB_DT_STRING, 0x09, 0x04};

static bool
lookup_connect_response_in(int fd, const struct vusb_connect_descriptors*=
 descs,
                           const struct usb_ctrlrequest* ctrl,
                           struct usb_qualifier_descriptor* qual,
                           char** response_data, uint32_t* response_lengt=
h)
{
  struct usb_device_index* index =3D lookup_usb_index(fd);
  uint8_t str_idx;
  if (!index)
    return false;
  switch (ctrl->bRequestType & USB_TYPE_MASK) {
  case USB_TYPE_STANDARD:
    switch (ctrl->bRequest) {
    case USB_REQ_GET_DESCRIPTOR:
      switch (ctrl->wValue >> 8) {
      case USB_DT_DEVICE:
        *response_data =3D (char*)index->dev;
        *response_length =3D sizeof(*index->dev);
        return true;
      case USB_DT_CONFIG:
        *response_data =3D (char*)index->config;
        *response_length =3D index->config_length;
        return true;
      case USB_DT_STRING:
        str_idx =3D (uint8_t)ctrl->wValue;
        if (descs && str_idx < descs->strs_len) {
          *response_data =3D descs->strs[str_idx].str;
          *response_length =3D descs->strs[str_idx].len;
          return true;
        }
        if (str_idx =3D=3D 0) {
          *response_data =3D (char*)&default_lang_id[0];
          *response_length =3D default_lang_id[0];
          return true;
        }
        *response_data =3D (char*)&default_string[0];
        *response_length =3D default_string[0];
        return true;
      case USB_DT_BOS:
        *response_data =3D descs->bos;
        *response_length =3D descs->bos_len;
        return true;
      case USB_DT_DEVICE_QUALIFIER:
        if (!descs->qual) {
          qual->bLength =3D sizeof(*qual);
          qual->bDescriptorType =3D USB_DT_DEVICE_QUALIFIER;
          qual->bcdUSB =3D index->dev->bcdUSB;
          qual->bDeviceClass =3D index->dev->bDeviceClass;
          qual->bDeviceSubClass =3D index->dev->bDeviceSubClass;
          qual->bDeviceProtocol =3D index->dev->bDeviceProtocol;
          qual->bMaxPacketSize0 =3D index->dev->bMaxPacketSize0;
          qual->bNumConfigurations =3D index->dev->bNumConfigurations;
          qual->bRESERVED =3D 0;
          *response_data =3D (char*)qual;
          *response_length =3D sizeof(*qual);
          return true;
        }
        *response_data =3D descs->qual;
        *response_length =3D descs->qual_len;
        return true;
      default:
        break;
      }
      break;
    default:
      break;
    }
    break;
  default:
    break;
  }
  return false;
}

typedef bool (*lookup_connect_out_response_t)(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done);

static bool lookup_connect_response_out_generic(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done)
{
  switch (ctrl->bRequestType & USB_TYPE_MASK) {
  case USB_TYPE_STANDARD:
    switch (ctrl->bRequest) {
    case USB_REQ_SET_CONFIGURATION:
      *done =3D true;
      return true;
    default:
      break;
    }
    break;
  }
  return false;
}

struct vusb_descriptor {
  uint8_t req_type;
  uint8_t desc_type;
  uint32_t len;
  char data[0];
} __attribute__((packed));

struct vusb_descriptors {
  uint32_t len;
  struct vusb_descriptor* generic;
  struct vusb_descriptor* descs[0];
} __attribute__((packed));

struct vusb_response {
  uint8_t type;
  uint8_t req;
  uint32_t len;
  char data[0];
} __attribute__((packed));

struct vusb_responses {
  uint32_t len;
  struct vusb_response* generic;
  struct vusb_response* resps[0];
} __attribute__((packed));

static bool lookup_control_response(const struct vusb_descriptors* descs,=

                                    const struct vusb_responses* resps,
                                    struct usb_ctrlrequest* ctrl,
                                    char** response_data,
                                    uint32_t* response_length)
{
  int descs_num =3D 0;
  int resps_num =3D 0;
  if (descs)
    descs_num =3D (descs->len - offsetof(struct vusb_descriptors, descs))=
 /
                sizeof(descs->descs[0]);
  if (resps)
    resps_num =3D (resps->len - offsetof(struct vusb_responses, resps)) /=

                sizeof(resps->resps[0]);
  uint8_t req =3D ctrl->bRequest;
  uint8_t req_type =3D ctrl->bRequestType & USB_TYPE_MASK;
  uint8_t desc_type =3D ctrl->wValue >> 8;
  if (req =3D=3D USB_REQ_GET_DESCRIPTOR) {
    int i;
    for (i =3D 0; i < descs_num; i++) {
      struct vusb_descriptor* desc =3D descs->descs[i];
      if (!desc)
        continue;
      if (desc->req_type =3D=3D req_type && desc->desc_type =3D=3D desc_t=
ype) {
        *response_length =3D desc->len;
        if (*response_length !=3D 0)
          *response_data =3D &desc->data[0];
        else
          *response_data =3D NULL;
        return true;
      }
    }
    if (descs && descs->generic) {
      *response_data =3D &descs->generic->data[0];
      *response_length =3D descs->generic->len;
      return true;
    }
  } else {
    int i;
    for (i =3D 0; i < resps_num; i++) {
      struct vusb_response* resp =3D resps->resps[i];
      if (!resp)
        continue;
      if (resp->type =3D=3D req_type && resp->req =3D=3D req) {
        *response_length =3D resp->len;
        if (*response_length !=3D 0)
          *response_data =3D &resp->data[0];
        else
          *response_data =3D NULL;
        return true;
      }
    }
    if (resps && resps->generic) {
      *response_data =3D &resps->generic->data[0];
      *response_length =3D resps->generic->len;
      return true;
    }
  }
  return false;
}

#define UDC_NAME_LENGTH_MAX 128

struct usb_raw_init {
  __u8 driver_name[UDC_NAME_LENGTH_MAX];
  __u8 device_name[UDC_NAME_LENGTH_MAX];
  __u8 speed;
};

enum usb_raw_event_type {
  USB_RAW_EVENT_INVALID =3D 0,
  USB_RAW_EVENT_CONNECT =3D 1,
  USB_RAW_EVENT_CONTROL =3D 2,
};

struct usb_raw_event {
  __u32 type;
  __u32 length;
  __u8 data[0];
};

struct usb_raw_ep_io {
  __u16 ep;
  __u16 flags;
  __u32 length;
  __u8 data[0];
};

#define USB_RAW_EPS_NUM_MAX 30
#define USB_RAW_EP_NAME_MAX 16
#define USB_RAW_EP_ADDR_ANY 0xff

struct usb_raw_ep_caps {
  __u32 type_control : 1;
  __u32 type_iso : 1;
  __u32 type_bulk : 1;
  __u32 type_int : 1;
  __u32 dir_in : 1;
  __u32 dir_out : 1;
};

struct usb_raw_ep_limits {
  __u16 maxpacket_limit;
  __u16 max_streams;
  __u32 reserved;
};

struct usb_raw_ep_info {
  __u8 name[USB_RAW_EP_NAME_MAX];
  __u32 addr;
  struct usb_raw_ep_caps caps;
  struct usb_raw_ep_limits limits;
};

struct usb_raw_eps_info {
  struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descript=
or)
#define USB_RAW_IOCTL_EP_DISABLE _IOW('U', 6, __u32)
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, __u32)
#define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)
#define USB_RAW_IOCTL_EP_SET_HALT _IOW('U', 13, __u32)
#define USB_RAW_IOCTL_EP_CLEAR_HALT _IOW('U', 14, __u32)
#define USB_RAW_IOCTL_EP_SET_WEDGE _IOW('U', 15, __u32)

static int usb_raw_open()
{
  return open("/dev/raw-gadget", O_RDWR);
}

static int usb_raw_init(int fd, uint32_t speed, const char* driver,
                        const char* device)
{
  struct usb_raw_init arg;
  strncpy((char*)&arg.driver_name[0], driver, sizeof(arg.driver_name));
  strncpy((char*)&arg.device_name[0], device, sizeof(arg.device_name));
  arg.speed =3D speed;
  return ioctl(fd, USB_RAW_IOCTL_INIT, &arg);
}

static int usb_raw_run(int fd)
{
  return ioctl(fd, USB_RAW_IOCTL_RUN, 0);
}

static int usb_raw_configure(int fd)
{
  return ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0);
}

static int usb_raw_vbus_draw(int fd, uint32_t power)
{
  return ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, power);
}

static int usb_raw_ep0_write(int fd, struct usb_raw_ep_io* io)
{
  return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, io);
}

static int usb_raw_ep0_read(int fd, struct usb_raw_ep_io* io)
{
  return ioctl(fd, USB_RAW_IOCTL_EP0_READ, io);
}

static int usb_raw_event_fetch(int fd, struct usb_raw_event* event)
{
  return ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, event);
}

static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc=
)
{
  return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);
}

static int usb_raw_ep_disable(int fd, int ep)
{
  return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);
}

static int usb_raw_ep0_stall(int fd)
{
  return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
}

static int lookup_interface(int fd, uint8_t bInterfaceNumber,
                            uint8_t bAlternateSetting)
{
  struct usb_device_index* index =3D lookup_usb_index(fd);
  if (!index)
    return -1;
  for (int i =3D 0; i < index->ifaces_num; i++) {
    if (index->ifaces[i].bInterfaceNumber =3D=3D bInterfaceNumber &&
        index->ifaces[i].bAlternateSetting =3D=3D bAlternateSetting)
      return i;
  }
  return -1;
}

#define USB_MAX_PACKET_SIZE 4096

struct usb_raw_control_event {
  struct usb_raw_event inner;
  struct usb_ctrlrequest ctrl;
  char data[USB_MAX_PACKET_SIZE];
};

struct usb_raw_ep_io_data {
  struct usb_raw_ep_io inner;
  char data[USB_MAX_PACKET_SIZE];
};

static void set_interface(int fd, int n)
{
  struct usb_device_index* index =3D lookup_usb_index(fd);
  if (!index)
    return;
  if (index->iface_cur >=3D 0 && index->iface_cur < index->ifaces_num) {
    for (int ep =3D 0; ep < index->ifaces[index->iface_cur].eps_num; ep++=
) {
      int rv =3D usb_raw_ep_disable(
          fd, index->ifaces[index->iface_cur].eps[ep].handle);
      if (rv < 0) {
      } else {
      }
    }
  }
  if (n >=3D 0 && n < index->ifaces_num) {
    for (int ep =3D 0; ep < index->ifaces[n].eps_num; ep++) {
      int rv =3D usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);
      if (rv < 0) {
      } else {
        index->ifaces[n].eps[ep].handle =3D rv;
      }
    }
    index->iface_cur =3D n;
  }
}

static int configure_device(int fd)
{
  struct usb_device_index* index =3D lookup_usb_index(fd);
  if (!index)
    return -1;
  int rv =3D usb_raw_vbus_draw(fd, index->bMaxPower);
  if (rv < 0) {
    return rv;
  }
  rv =3D usb_raw_configure(fd);
  if (rv < 0) {
    return rv;
  }
  set_interface(fd, 0);
  return 0;
}

static volatile long
syz_usb_connect_impl(uint64_t speed, uint64_t dev_len, const char* dev,
                     const struct vusb_connect_descriptors* descs,
                     lookup_connect_out_response_t lookup_connect_respons=
e_out)
{
  if (!dev) {
    return -1;
  }
  int fd =3D usb_raw_open();
  if (fd < 0) {
    return fd;
  }
  if (fd >=3D MAX_FDS) {
    close(fd);
    return -1;
  }
  struct usb_device_index* index =3D add_usb_index(fd, dev, dev_len);
  if (!index) {
    return -1;
  }
  char device[32];
  sprintf(&device[0], "dummy_udc.%llu", procid);
  int rv =3D usb_raw_init(fd, speed, "dummy_udc", &device[0]);
  if (rv < 0) {
    return rv;
  }
  rv =3D usb_raw_run(fd);
  if (rv < 0) {
    return rv;
  }
  bool done =3D false;
  while (!done) {
    struct usb_raw_control_event event;
    event.inner.type =3D 0;
    event.inner.length =3D sizeof(event.ctrl);
    rv =3D usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
    if (rv < 0) {
      return rv;
    }
    if (event.inner.type !=3D USB_RAW_EVENT_CONTROL)
      continue;
    char* response_data =3D NULL;
    uint32_t response_length =3D 0;
    struct usb_qualifier_descriptor qual;
    if (event.ctrl.bRequestType & USB_DIR_IN) {
      if (!lookup_connect_response_in(fd, descs, &event.ctrl, &qual,
                                      &response_data, &response_length)) =
{
        usb_raw_ep0_stall(fd);
        continue;
      }
    } else {
      if (!lookup_connect_response_out(fd, descs, &event.ctrl, &done)) {
        usb_raw_ep0_stall(fd);
        continue;
      }
      response_data =3D NULL;
      response_length =3D event.ctrl.wLength;
    }
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDAR=
D &&
        event.ctrl.bRequest =3D=3D USB_REQ_SET_CONFIGURATION) {
      rv =3D configure_device(fd);
      if (rv < 0) {
        return rv;
      }
    }
    struct usb_raw_ep_io_data response;
    response.inner.ep =3D 0;
    response.inner.flags =3D 0;
    if (response_length > sizeof(response.data))
      response_length =3D 0;
    if (event.ctrl.wLength < response_length)
      response_length =3D event.ctrl.wLength;
    response.inner.length =3D response_length;
    if (response_data)
      memcpy(&response.data[0], response_data, response_length);
    else
      memset(&response.data[0], 0, response_length);
    if (event.ctrl.bRequestType & USB_DIR_IN) {
      rv =3D usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
    } else {
      rv =3D usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
    }
    if (rv < 0) {
      return rv;
    }
  }
  sleep_ms(200);
  return fd;
}

static volatile long syz_usb_connect(volatile long a0, volatile long a1,
                                     volatile long a2, volatile long a3)
{
  uint64_t speed =3D a0;
  uint64_t dev_len =3D a1;
  const char* dev =3D (const char*)a2;
  const struct vusb_connect_descriptors* descs =3D
      (const struct vusb_connect_descriptors*)a3;
  return syz_usb_connect_impl(speed, dev_len, dev, descs,
                              &lookup_connect_response_out_generic);
}

static volatile long syz_usb_control_io(volatile long a0, volatile long a=
1,
                                        volatile long a2)
{
  int fd =3D a0;
  const struct vusb_descriptors* descs =3D (const struct vusb_descriptors=
*)a1;
  const struct vusb_responses* resps =3D (const struct vusb_responses*)a2=
;
  struct usb_raw_control_event event;
  event.inner.type =3D 0;
  event.inner.length =3D USB_MAX_PACKET_SIZE;
  int rv =3D usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
  if (rv < 0) {
    return rv;
  }
  if (event.inner.type !=3D USB_RAW_EVENT_CONTROL) {
    return -1;
  }
  char* response_data =3D NULL;
  uint32_t response_length =3D 0;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    if (!lookup_control_response(descs, resps, &event.ctrl, &response_dat=
a,
                                 &response_length)) {
      usb_raw_ep0_stall(fd);
      return -1;
    }
  } else {
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDAR=
D ||
        event.ctrl.bRequest =3D=3D USB_REQ_SET_INTERFACE) {
      int iface_num =3D event.ctrl.wIndex;
      int alt_set =3D event.ctrl.wValue;
      int iface_index =3D lookup_interface(fd, iface_num, alt_set);
      if (iface_index < 0) {
      } else {
        set_interface(fd, iface_index);
      }
    }
    response_length =3D event.ctrl.wLength;
  }
  struct usb_raw_ep_io_data response;
  response.inner.ep =3D 0;
  response.inner.flags =3D 0;
  if (response_length > sizeof(response.data))
    response_length =3D 0;
  if (event.ctrl.wLength < response_length)
    response_length =3D event.ctrl.wLength;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && !event.ctrl.wLength) {
    response_length =3D USB_MAX_PACKET_SIZE;
  }
  response.inner.length =3D response_length;
  if (response_data)
    memcpy(&response.data[0], response_data, response_length);
  else
    memset(&response.data[0], 0, response_length);
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    rv =3D usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
  } else {
    rv =3D usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
  }
  if (rv < 0) {
    return rv;
  }
  sleep_ms(200);
  return 0;
}

uint64_t r[1] =3D {0xffffffffffffffff};

int main(void)
{
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
          /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
  const char* reason;
  (void)reason;
  intptr_t res =3D 0;
  if (write(1, "executing program\n", sizeof("executing program\n") - 1))=
 {
  }
  //  syz_usb_connect arguments: [
  //    speed: usb_device_speed =3D 0x0 (8 bytes)
  //    dev_len: len =3D 0x24 (8 bytes)
  //    dev: ptr[in, usb_device_descriptor] {
  //      usb_device_descriptor {
  //        inner: usb_device_descriptor_verbose_t[flags[usb_versions, in=
t16],
  //        0, 0, 0, flags[usb_device_max_packet_sizes, int8], 0, 0, 0,
  //        array[usb_config_descriptor, 1]] {
  //          bLength: const =3D 0x12 (1 bytes)
  //          bDescriptorType: const =3D 0x1 (1 bytes)
  //          bcdUSB: usb_versions =3D 0x0 (2 bytes)
  //          bDeviceClass: const =3D 0x97 (1 bytes)
  //          bDeviceSubClass: const =3D 0xff (1 bytes)
  //          bDeviceProtocol: const =3D 0x82 (1 bytes)
  //          bMaxPacketSize0: usb_device_max_packet_sizes =3D 0x8 (1 byt=
es)
  //          idVendor: const =3D 0x2058 (2 bytes)
  //          idProduct: const =3D 0x1005 (2 bytes)
  //          bcdDevice: const =3D 0xc19b (2 bytes)
  //          iManufacturer: const =3D 0x0 (1 bytes)
  //          iProduct: const =3D 0x0 (1 bytes)
  //          iSerialNumber: const =3D 0x0 (1 bytes)
  //          bNumConfigurations: len =3D 0x1 (1 bytes)
  //          configs: array[usb_config_descriptor] {
  //            usb_config_descriptor {
  //              inner: usb_config_descriptor_verbose_t[int8, len[interf=
aces,
  //              int8], int8, flags[usb_config_attributes, int8], int8,
  //              array[usb_interface_descriptor, 1:4]] {
  //                bLength: const =3D 0x9 (1 bytes)
  //                bDescriptorType: const =3D 0x2 (1 bytes)
  //                wTotalLength: len =3D 0x12 (2 bytes)
  //                bNumInterfaces: len =3D 0x1 (1 bytes)
  //                bConfigurationValue: int8 =3D 0x0 (1 bytes)
  //                iConfiguration: int8 =3D 0x0 (1 bytes)
  //                bmAttributes: usb_config_attributes =3D 0x0 (1 bytes)=

  //                bMaxPower: int8 =3D 0x0 (1 bytes)
  //                interfaces: array[usb_interface_descriptor] {
  //                  usb_interface_descriptor {
  //                    inner: usb_interface_descriptor_verbose_t[int8, i=
nt8,
  //                    len[endpoints, int8], const[0, int8], const[0, in=
t8],
  //                    const[0, int8], int8,
  //                    array[usb_interface_extra_descriptor, 0:2],
  //                    array[usb_endpoint_descriptor, 0:16]] {
  //                      bLength: const =3D 0x9 (1 bytes)
  //                      bDescriptorType: const =3D 0x4 (1 bytes)
  //                      bInterfaceNumber: int8 =3D 0x8f (1 bytes)
  //                      bAlternateSetting: int8 =3D 0x0 (1 bytes)
  //                      bNumEndpoints: len =3D 0x0 (1 bytes)
  //                      bInterfaceClass: const =3D 0xbf (1 bytes)
  //                      bInterfaceSubClass: const =3D 0x57 (1 bytes)
  //                      bInterfaceProtocol: const =3D 0x5a (1 bytes)
  //                      iInterface: int8 =3D 0x0 (1 bytes)
  //                      extra: array[usb_interface_extra_descriptor] {
  //                      }
  //                      endpoints: array[usb_endpoint_descriptor] {
  //                      }
  //                    }
  //                  }
  //                }
  //              }
  //            }
  //          }
  //        }
  //      }
  //    }
  //    conn_descs: nil
  //  ]
  //  returns fd_usb
  *(uint8_t*)0x20000000 =3D 0x12;
  *(uint8_t*)0x20000001 =3D 1;
  *(uint16_t*)0x20000002 =3D 0;
  *(uint8_t*)0x20000004 =3D 0x97;
  *(uint8_t*)0x20000005 =3D -1;
  *(uint8_t*)0x20000006 =3D 0x82;
  *(uint8_t*)0x20000007 =3D 8;
  *(uint16_t*)0x20000008 =3D 0x2058;
  *(uint16_t*)0x2000000a =3D 0x1005;
  *(uint16_t*)0x2000000c =3D 0xc19b;
  *(uint8_t*)0x2000000e =3D 0;
  *(uint8_t*)0x2000000f =3D 0;
  *(uint8_t*)0x20000010 =3D 0;
  *(uint8_t*)0x20000011 =3D 1;
  *(uint8_t*)0x20000012 =3D 9;
  *(uint8_t*)0x20000013 =3D 2;
  *(uint16_t*)0x20000014 =3D 0x12;
  *(uint8_t*)0x20000016 =3D 1;
  *(uint8_t*)0x20000017 =3D 0;
  *(uint8_t*)0x20000018 =3D 0;
  *(uint8_t*)0x20000019 =3D 0;
  *(uint8_t*)0x2000001a =3D 0;
  *(uint8_t*)0x2000001b =3D 9;
  *(uint8_t*)0x2000001c =3D 4;
  *(uint8_t*)0x2000001d =3D 0x8f;
  *(uint8_t*)0x2000001e =3D 0;
  *(uint8_t*)0x2000001f =3D 0;
  *(uint8_t*)0x20000020 =3D 0xbf;
  *(uint8_t*)0x20000021 =3D 0x57;
  *(uint8_t*)0x20000022 =3D 0x5a;
  *(uint8_t*)0x20000023 =3D 0;
  res =3D -1;
  res =3D syz_usb_connect(/*speed=3D*/0, /*dev_len=3D*/0x24, /*dev=3D*/0x=
20000000,
                        /*conn_descs=3D*/0);
  if (res !=3D -1)
    r[0] =3D res;
  //  syz_usb_control_io$cdc_ncm arguments: [
  //    fd: fd_usb_cdc_ncm (resource)
  //    descs: ptr[in, vusb_descriptors_cdc_ncm] {
  //      vusb_descriptors_cdc_ncm {
  //        len: len =3D 0x14 (4 bytes)
  //        generic: ptr[in, vusb_descriptor_generic] {
  //          vusb_descriptor_generic {
  //            req_type: usb_request_types =3D 0x40 (1 bytes)
  //            desc_type: usb_descriptor_types =3D 0x0 (1 bytes)
  //            len: bytesize =3D 0x66 (4 bytes)
  //            data: usb_generic_descriptor {
  //              bLength: len =3D 0x66 (1 bytes)
  //              bDescriptorType: usb_descriptor_types =3D 0x23 (1 bytes=
)
  //              data: buffer: {6f 2c 18 38 81 12 ef ff c4 88 90 80 ab 3=
1 f0 d2
  //              98 45 65 04 98 64 50 2a 19 01 c1 11 4c 7d e3 02 80 e1 d=
e 22 28
  //              82 86 cb c9 6d e9 31 49 c6 4b a4 0c 48 6c 6d 86 18 f8 6=
7 66 0d
  //              21 7e fe 65 d2 04 e4 28 4c 88 4f f6 b3 32 6c dc 12 4b 3=
c 44 4b
  //              78 97 f5 3d 60 4c a3 ec f7 9a d0 a1 36 0b 96 39 87 48 9=
a d1
  //              d1} (length 0x64)
  //            }
  //          }
  //        }
  //        USB_DT_STRING: ptr[in, vusb_descriptor_t[USB_TYPE_STANDARD,
  //        USB_DT_STRING, usb_string_descriptor_t[usb_cdc_ecm_mac]]] {
  //          vusb_descriptor_t[USB_TYPE_STANDARD, USB_DT_STRING,
  //          usb_string_descriptor_t[usb_cdc_ecm_mac]] {
  //            type: const =3D 0x0 (1 bytes)
  //            req: const =3D 0x3 (1 bytes)
  //            len: bytesize =3D 0x1a (4 bytes)
  //            data: usb_string_descriptor_t[usb_cdc_ecm_mac] {
  //              bLength: len =3D 0x1a (1 bytes)
  //              bDescriptorType: const =3D 0x3 (1 bytes)
  //              data: usb_cdc_ecm_mac {
  //                data0: const =3D 0x3400320034003200 (8 bytes)
  //                data1: const =3D 0x3400320034003200 (8 bytes)
  //                data2: const =3D 0x3400320034003200 (8 bytes)
  //              }
  //            }
  //          }
  //        }
  //      }
  //    }
  //    resps: ptr[in, vusb_responses_cdc_ncm] {
  //      vusb_responses_cdc_ncm {
  //        len: len =3D 0x44 (4 bytes)
  //        generic: ptr[in, vusb_response_generic] {
  //          vusb_response_generic {
  //            type: usb_request_types =3D 0x40 (1 bytes)
  //            req: usb_requests =3D 0x6 (1 bytes)
  //            len: bytesize =3D 0xc9 (4 bytes)
  //            data: buffer: {e8 39 c6 2c aa 4b 30 55 5c 01 ce 55 05 14 =
41 12
  //            eb 8d 79 23 38 3a 6a cb d7 b1 07 1c 0b 04 35 96 74 d1 08 =
37 18
  //            24 19 a1 be 17 91 ea 59 10 49 21 3c bc ea d0 5c 73 d3 02 =
9f 9d
  //            72 86 3d 81 6c 86 2b 8f 48 76 06 64 ab c2 bf 72 b5 b9 56 =
7a a1
  //            fc 9b 10 21 37 d0 c8 a2 c4 d8 93 47 35 9b 0f d8 1f 0f 1e =
c8 ad
  //            4e b1 6b 5d 88 60 17 5c 6f 22 21 48 31 82 8e ea d6 48 50 =
37 05
  //            b5 eb 20 12 43 a6 ad ea 26 45 1b 3e f7 2e 63 26 cf 80 d5 =
79 77
  //            3d c5 2b 16 7d bb 56 ef a4 1e d5 09 2b 8b 20 90 4c 8a a2 =
8b db
  //            a2 0a ad 3a c4 85 91 91 49 09 01 ed aa 2a 4b 62 45 2f 9e =
84 f2
  //            19 de 47 c7 67 a8 52 e9 6e d3 c7 60 c0 43 1c 34 23} (leng=
th
  //            0xc9)
  //          }
  //        }
  //        USB_REQ_GET_INTERFACE: ptr[in, vusb_response_t[USB_TYPE_STAND=
ARD,
  //        USB_REQ_GET_INTERFACE, int8]] {
  //          vusb_response_t[USB_TYPE_STANDARD, USB_REQ_GET_INTERFACE, i=
nt8] {
  //            type: const =3D 0x0 (1 bytes)
  //            req: const =3D 0xa (1 bytes)
  //            len: bytesize =3D 0x1 (4 bytes)
  //            data: int8 =3D 0x8 (1 bytes)
  //          }
  //        }
  //        USB_REQ_GET_CONFIGURATION: ptr[in,
  //        vusb_response_t[USB_TYPE_STANDARD, USB_REQ_GET_CONFIGURATION,=
 int8]]
  //        {
  //          vusb_response_t[USB_TYPE_STANDARD, USB_REQ_GET_CONFIGURATIO=
N,
  //          int8] {
  //            type: const =3D 0x0 (1 bytes)
  //            req: const =3D 0x8 (1 bytes)
  //            len: bytesize =3D 0x1 (4 bytes)
  //            data: int8 =3D 0x9 (1 bytes)
  //          }
  //        }
  //        USB_CDC_GET_NTB_PARAMETERS: ptr[in, vusb_response_t[USB_TYPE_=
CLASS,
  //        USB_CDC_GET_NTB_PARAMETERS, usb_cdc_ncm_ntb_parameters]] {
  //          vusb_response_t[USB_TYPE_CLASS, USB_CDC_GET_NTB_PARAMETERS,=

  //          usb_cdc_ncm_ntb_parameters] {
  //            type: const =3D 0x20 (1 bytes)
  //            req: const =3D 0x80 (1 bytes)
  //            len: bytesize =3D 0x1c (4 bytes)
  //            data: usb_cdc_ncm_ntb_parameters {
  //              wLength: int16 =3D 0x4b (2 bytes)
  //              bmNtbFormatsSupported: int16 =3D 0x8 (2 bytes)
  //              dwNtbInMaxSize: int32 =3D 0x8 (4 bytes)
  //              wNdpInDivisor: int16 =3D 0x2 (2 bytes)
  //              wNdpInPayloadRemainder: int16 =3D 0x7 (2 bytes)
  //              wNdpInAlignment: int16 =3D 0xc373 (2 bytes)
  //              wPadding1: int16 =3D 0x8 (2 bytes)
  //              dwNtbOutMaxSize: int32 =3D 0xe (4 bytes)
  //              wNdpOutDivisor: int16 =3D 0x2 (2 bytes)
  //              wNdpOutPayloadRemainder: int16 =3D 0x80 (2 bytes)
  //              wNdpOutAlignment: int16 =3D 0x112 (2 bytes)
  //              wNtbOutMaxDatagrams: int16 =3D 0x4c (2 bytes)
  //            }
  //          }
  //        }
  //        USB_CDC_GET_NTB_INPUT_SIZE: ptr[in, vusb_response_t[USB_TYPE_=
CLASS,
  //        USB_CDC_GET_NTB_INPUT_SIZE, int32]] {
  //          vusb_response_t[USB_TYPE_CLASS, USB_CDC_GET_NTB_INPUT_SIZE,=
 int32]
  //          {
  //            type: const =3D 0x20 (1 bytes)
  //            req: const =3D 0x85 (1 bytes)
  //            len: bytesize =3D 0x4 (4 bytes)
  //            data: int32 =3D 0x91f409a (4 bytes)
  //          }
  //        }
  //        USB_CDC_GET_NTB_FORMAT: ptr[in, vusb_response_t[USB_TYPE_CLAS=
S,
  //        USB_CDC_GET_NTB_FORMAT, int16[0:1]]] {
  //          vusb_response_t[USB_TYPE_CLASS, USB_CDC_GET_NTB_FORMAT,
  //          int16[0:1]] {
  //            type: const =3D 0x20 (1 bytes)
  //            req: const =3D 0x83 (1 bytes)
  //            len: bytesize =3D 0x2 (4 bytes)
  //            data: int16 =3D 0x1 (2 bytes)
  //          }
  //        }
  //        USB_CDC_GET_MAX_DATAGRAM_SIZE: ptr[in,
  //        vusb_response_t[USB_TYPE_CLASS, USB_CDC_GET_MAX_DATAGRAM_SIZE=
,
  //        int16]] {
  //          vusb_response_t[USB_TYPE_CLASS, USB_CDC_GET_MAX_DATAGRAM_SI=
ZE,
  //          int16] {
  //            type: const =3D 0x20 (1 bytes)
  //            req: const =3D 0x87 (1 bytes)
  //            len: bytesize =3D 0x2 (4 bytes)
  //            data: int16 =3D 0x9 (2 bytes)
  //          }
  //        }
  //        USB_CDC_GET_CRC_MODE: ptr[in, vusb_response_t[USB_TYPE_CLASS,=

  //        USB_CDC_GET_CRC_MODE, int16[0:1]]] {
  //          vusb_response_t[USB_TYPE_CLASS, USB_CDC_GET_CRC_MODE, int16=
[0:1]]
  //          {
  //            type: const =3D 0x20 (1 bytes)
  //            req: const =3D 0x89 (1 bytes)
  //            len: bytesize =3D 0x2 (4 bytes)
  //            data: int16 =3D 0x1 (2 bytes)
  //          }
  //        }
  //      }
  //    }
  //  ]
  *(uint32_t*)0x20000100 =3D 0x14;
  *(uint64_t*)0x20000104 =3D 0x20000040;
  *(uint8_t*)0x20000040 =3D 0x40;
  *(uint8_t*)0x20000041 =3D 0;
  *(uint32_t*)0x20000042 =3D 0x66;
  *(uint8_t*)0x20000046 =3D 0x66;
  *(uint8_t*)0x20000047 =3D 0x23;
  memcpy((void*)0x20000048,
         "\x6f\x2c\x18\x38\x81\x12\xef\xff\xc4\x88\x90\x80\xab\x31\xf0\xd=
2\x98"
         "\x45\x65\x04\x98\x64\x50\x2a\x19\x01\xc1\x11\x4c\x7d\xe3\x02\x8=
0\xe1"
         "\xde\x22\x28\x82\x86\xcb\xc9\x6d\xe9\x31\x49\xc6\x4b\xa4\x0c\x4=
8\x6c"
         "\x6d\x86\x18\xf8\x67\x66\x0d\x21\x7e\xfe\x65\xd2\x04\xe4\x28\x4=
c\x88"
         "\x4f\xf6\xb3\x32\x6c\xdc\x12\x4b\x3c\x44\x4b\x78\x97\xf5\x3d\x6=
0\x4c"
         "\xa3\xec\xf7\x9a\xd0\xa1\x36\x0b\x96\x39\x87\x48\x9a\xd1\xd1",
         100);
  *(uint64_t*)0x2000010c =3D 0x200000c0;
  *(uint8_t*)0x200000c0 =3D 0;
  *(uint8_t*)0x200000c1 =3D 3;
  *(uint32_t*)0x200000c2 =3D 0x1a;
  *(uint8_t*)0x200000c6 =3D 0x1a;
  *(uint8_t*)0x200000c7 =3D 3;
  *(uint64_t*)0x200000c8 =3D htobe64(0x3400320034003200);
  *(uint64_t*)0x200000d0 =3D htobe64(0x3400320034003200);
  *(uint64_t*)0x200000d8 =3D htobe64(0x3400320034003200);
  *(uint32_t*)0x20000400 =3D 0x44;
  *(uint64_t*)0x20000404 =3D 0x20000140;
  *(uint8_t*)0x20000140 =3D 0x40;
  *(uint8_t*)0x20000141 =3D 6;
  *(uint32_t*)0x20000142 =3D 0xc9;
  memcpy((void*)0x20000146,
         "\xe8\x39\xc6\x2c\xaa\x4b\x30\x55\x5c\x01\xce\x55\x05\x14\x41\x1=
2\xeb"
         "\x8d\x79\x23\x38\x3a\x6a\xcb\xd7\xb1\x07\x1c\x0b\x04\x35\x96\x7=
4\xd1"
         "\x08\x37\x18\x24\x19\xa1\xbe\x17\x91\xea\x59\x10\x49\x21\x3c\xb=
c\xea"
         "\xd0\x5c\x73\xd3\x02\x9f\x9d\x72\x86\x3d\x81\x6c\x86\x2b\x8f\x4=
8\x76"
         "\x06\x64\xab\xc2\xbf\x72\xb5\xb9\x56\x7a\xa1\xfc\x9b\x10\x21\x3=
7\xd0"
         "\xc8\xa2\xc4\xd8\x93\x47\x35\x9b\x0f\xd8\x1f\x0f\x1e\xc8\xad\x4=
e\xb1"
         "\x6b\x5d\x88\x60\x17\x5c\x6f\x22\x21\x48\x31\x82\x8e\xea\xd6\x4=
8\x50"
         "\x37\x05\xb5\xeb\x20\x12\x43\xa6\xad\xea\x26\x45\x1b\x3e\xf7\x2=
e\x63"
         "\x26\xcf\x80\xd5\x79\x77\x3d\xc5\x2b\x16\x7d\xbb\x56\xef\xa4\x1=
e\xd5"
         "\x09\x2b\x8b\x20\x90\x4c\x8a\xa2\x8b\xdb\xa2\x0a\xad\x3a\xc4\x8=
5\x91"
         "\x91\x49\x09\x01\xed\xaa\x2a\x4b\x62\x45\x2f\x9e\x84\xf2\x19\xd=
e\x47"
         "\xc7\x67\xa8\x52\xe9\x6e\xd3\xc7\x60\xc0\x43\x1c\x34\x23",
         201);
  *(uint64_t*)0x2000040c =3D 0x20000240;
  *(uint8_t*)0x20000240 =3D 0;
  *(uint8_t*)0x20000241 =3D 0xa;
  *(uint32_t*)0x20000242 =3D 1;
  *(uint8_t*)0x20000246 =3D 8;
  *(uint64_t*)0x20000414 =3D 0x20000280;
  *(uint8_t*)0x20000280 =3D 0;
  *(uint8_t*)0x20000281 =3D 8;
  *(uint32_t*)0x20000282 =3D 1;
  *(uint8_t*)0x20000286 =3D 9;
  *(uint64_t*)0x2000041c =3D 0x200002c0;
  *(uint8_t*)0x200002c0 =3D 0x20;
  *(uint8_t*)0x200002c1 =3D 0x80;
  *(uint32_t*)0x200002c2 =3D 0x1c;
  *(uint16_t*)0x200002c6 =3D 0x4b;
  *(uint16_t*)0x200002c8 =3D 8;
  *(uint32_t*)0x200002ca =3D 8;
  *(uint16_t*)0x200002ce =3D 2;
  *(uint16_t*)0x200002d0 =3D 7;
  *(uint16_t*)0x200002d2 =3D 0xc373;
  *(uint16_t*)0x200002d4 =3D 8;
  *(uint32_t*)0x200002d6 =3D 0xe;
  *(uint16_t*)0x200002da =3D 2;
  *(uint16_t*)0x200002dc =3D 0x80;
  *(uint16_t*)0x200002de =3D 0x112;
  *(uint16_t*)0x200002e0 =3D 0x4c;
  *(uint64_t*)0x20000424 =3D 0x20000300;
  *(uint8_t*)0x20000300 =3D 0x20;
  *(uint8_t*)0x20000301 =3D 0x85;
  *(uint32_t*)0x20000302 =3D 4;
  *(uint32_t*)0x20000306 =3D 0x91f409a;
  *(uint64_t*)0x2000042c =3D 0x20000340;
  *(uint8_t*)0x20000340 =3D 0x20;
  *(uint8_t*)0x20000341 =3D 0x83;
  *(uint32_t*)0x20000342 =3D 2;
  *(uint16_t*)0x20000346 =3D 1;
  *(uint64_t*)0x20000434 =3D 0x20000380;
  *(uint8_t*)0x20000380 =3D 0x20;
  *(uint8_t*)0x20000381 =3D 0x87;
  *(uint32_t*)0x20000382 =3D 2;
  *(uint16_t*)0x20000386 =3D 9;
  *(uint64_t*)0x2000043c =3D 0x200003c0;
  *(uint8_t*)0x200003c0 =3D 0x20;
  *(uint8_t*)0x200003c1 =3D 0x89;
  *(uint32_t*)0x200003c2 =3D 2;
  *(uint16_t*)0x200003c6 =3D 1;
  syz_usb_control_io(/*fd=3D*/r[0], /*descs=3D*/0x20000100, /*resps=3D*/0=
x20000400);
  return 0;
}

Thank you!

Best regards,
Yunseong

