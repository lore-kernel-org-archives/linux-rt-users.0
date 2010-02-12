From: Armin Steinhoff <armin@steinhoff.de>
Subject: mapping of PCI memory to  user space not working with uio.c ?
Date: Fri, 12 Feb 2010 21:54:59 +0100
Message-ID: <4B75C023.4070908@steinhoff.de>
References: <loom.20100209T081421-234@post.gmane.org>	<20100210163818.7f54ec3a@torg>	<4B73B7B5.4070509@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060903040401080304040105"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55935 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408Ab0BLUxm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Feb 2010 15:53:42 -0500
In-Reply-To: <4B73B7B5.4070509@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060903040401080304040105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

I need some help.

I'm writing a user space driver for a PCI board.
The kernel part is working well ... all infos in sysfs are correct.

The mappings of the memories behind the BARs are "working" ... but the 
returned addresses are not valid.

Is it possible that the call remap_pfn_range used in uio.c are not 
working with PCI memory ??

I have attached the mapping procedure of the user space and the kernel part.

The mapping of BAR[2] (it's kernel memory) is valid ...


Best Regards

--Armin

--------------060903040401080304040105
Content-Type: text/x-csrc;
 name="uio_ems.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uio_ems.c"

/*
 * UIO can CAN L2 PCI
 *
 * (C) Armin Steinhoff <as@steinhoff-automation.com>
 * (C) 2007 Hans J. Koch <hjk@linutronix.de>
 * Original code (C) 2005 Benedikt Spranger <b.spranger@linutronix.de>
 *
 * Licensed under GPL version 2 only.
 *
 */

#include <linux/device.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/uio_driver.h>

#include <asm/io.h>

#define DEBUG 1

#define PCI_VENDORID 0x110A
#define PCI_DEVICEID 0x2104
#define INT_QUEUE_SIZE 64

static unsigned char IntIx, * IntQ;
static	void __iomem *ISR; 
static	void __iomem *ICR; 

static irqreturn_t CAN_handler(int irq, struct uio_info *dev_info)
{
	
    // check PITA ICR ...
	if(*((unsigned long *)ICR) & 0x02) // our interrupt ?
	{
		IntQ[IntIx] = *((unsigned char *)ISR);
		IntIx = (IntIx + 1) & 0xF ; // modulo 16

		*((unsigned long *)ICR) = 0x02; // confirm interrupt 
		return(IRQ_HANDLED);
	}
	else
		return(IRQ_NONE);

}

static int __devinit ems_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	struct uio_info *info;
	int err;
	
	info = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
	if (!info)
		return -ENOMEM;

	// if (pci_enable_device(dev)) goto out_free;
	err = pci_enable_device(dev);
	if (err) {
		dev_err(&dev->dev, "%s: pci_enable_device failed: %d\n", __func__, err);
		return err;
	}

	if (pci_request_regions(dev, "uio_ems"))
		goto out_disable;

	info->mem[0].addr = pci_resource_start(dev, 0);
	if (!info->mem[0].addr)
		goto out_release;	
	info->mem[0].size = pci_resource_len(dev, 0);
	info->mem[0].memtype = UIO_MEM_PHYS;
	
	info->mem[0].internal_addr = ioremap(info->mem[0].addr,info->mem[0].size);
	if (!info->mem[0].internal_addr)
		goto out_release;
	
	// disable interrupt at PITA level 
	*( (unsigned long *)( info->mem[0].internal_addr )) &= ~0x20000; // reset Bit 17

	info->mem[1].addr = pci_resource_start(dev, 1);
	if (!info->mem[1].addr)
		goto out_release;	
	info->mem[1].size = pci_resource_len(dev, 1);
	info->mem[1].memtype = UIO_MEM_PHYS;
	
	info->mem[1].internal_addr = ioremap(info->mem[1].addr,info->mem[1].size);
	if (!info->mem[1].internal_addr)
		goto out_release;
	
	// interrupt queue
	info->mem[2].addr = (unsigned long)kmalloc(64, GFP_KERNEL);
	IntQ = (unsigned char * )info->mem[2].addr;
	
	if (!info->mem[2].addr)
		goto out_unmap1;
	
	memset(IntQ, 0x00, 16);
	IntIx = 0;

	info->mem[2].memtype = UIO_MEM_LOGICAL;
	info->mem[2].size = 64;
	
	ISR = info->mem[1].internal_addr + 12 + 0x400;	// interrupt status channel 1
	ICR = info->mem[0].internal_addr;
	*((unsigned long *)ICR) = 0x02; // confirm interrupt 
	
	info->name = "uio_ems";	
	info->version = "0.0.1";
	info->irq = dev->irq;
	info->irq_flags |= IRQF_SHARED;
	info->handler = CAN_handler;

	if (uio_register_device(&dev->dev, info))
		goto out_kfree;

	pci_set_drvdata(dev, info);
	printk("can_pci_probe end\n");
	return 0;
	
out_kfree:	
	kfree((void *)info->mem[2].addr);
out_unmap1:	
	iounmap(info->mem[1].internal_addr);		
	iounmap(info->mem[0].internal_addr);
out_release:
	pci_release_regions(dev);
out_disable:
	pci_disable_device(dev);
	kfree (info);
	printk("CAN_PCI: -ENODEV\n");
	return -ENODEV;
}

static void ems_pci_remove(struct pci_dev *dev)
{
	struct uio_info *info = pci_get_drvdata(dev);

	uio_unregister_device(info);
	pci_release_regions(dev);
	pci_disable_device(dev);
	pci_set_drvdata(dev, NULL);
	iounmap(info->mem[0].internal_addr);
	iounmap(info->mem[1].internal_addr);
	kfree((void *)info->mem[2].addr);
	kfree (info);
}

static struct pci_device_id ems_pci_ids[] __devinitdata = {
	{
		PCI_VENDORID, PCI_DEVICEID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
	},
	{ 0, }
};

static struct pci_driver ems_pci_driver = {
	.name = "uio_ems",
	.id_table = ems_pci_ids,
	.probe    = ems_pci_probe,
	.remove   = ems_pci_remove,
};

static int __init ems_init_module(void)
{
	int ret;

	ret = pci_register_driver(&ems_pci_driver);

	return ret;
}

static void __exit ems_exit_module(void)
{
	pci_unregister_driver(&ems_pci_driver);
}

module_init(ems_init_module);
module_exit(ems_exit_module);

MODULE_DEVICE_TABLE(pci, ems_pci_ids);
MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("A. Steinhoff");

--------------060903040401080304040105
Content-Type: text/x-csrc;
 name="user_space_mmap.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="user_space_mmap.c"

aW50IGRvX21hcHBpbmdzKHZvaWQpCnsKCWludCAgc2l6ZV9mZDsKCWludCB1aW9fc2l6ZTsK
CQoJc2l6ZV9mZCA9IG9wZW4oIFVJT19TSVpFMCwgT19SRE9OTFkgKTsKCWlmKCBzaXplX2Zk
PDAgfHwgdWlvX2ZkPDAgKSB7CgkJZnByaW50ZihzdGRlcnIsIkNhbid0IG9wZW4gVUlPIGZp
bGUgMC4uLlxuIik7CgkJcmV0dXJuIC0xOwp9CglyZWFkKCBzaXplX2ZkLCB1aW9fc2l6ZV9i
dWYsIHNpemVvZih1aW9fc2l6ZV9idWYpICk7Cgl1aW9fc2l6ZSA9IChpbnQpc3RydG9sKCB1
aW9fc2l6ZV9idWYsIE5VTEwsIDAgKTsKCUJBUlswXSA9IChCWVRFICopbW1hcChOVUxMLCB1
aW9fc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJFRCwgdWlvX2ZkLCAw
KTsKCWlmKEJBUlswXSA9PSBNQVBfRkFJTEVEKSBwZXJyb3IoIkJBUjA6XG4iKTsKCWNsb3Nl
KHNpemVfZmQpOwoJCglzaXplX2ZkID0gb3BlbiggVUlPX1NJWkUxLCBPX1JET05MWSApOwoJ
aWYoIHNpemVfZmQ8MCApIHsKCQlmcHJpbnRmKHN0ZGVyciwiQ2FuJ3Qgb3BlbiBVSU8gZmls
ZSAxLi4uXG4iKTsKCQlyZXR1cm4gLTE7Cn0KCXJlYWQoIHNpemVfZmQsIHVpb19zaXplX2J1
Ziwgc2l6ZW9mKHVpb19zaXplX2J1ZikgKTsKCXVpb19zaXplID0gKGludClzdHJ0b2woIHVp
b19zaXplX2J1ZiwgTlVMTCwgMCApOwoJQkFSWzFdID0gKEJZVEUgKiltbWFwKE5VTEwsIHVp
b19zaXplLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBfU0hBUkVELCB1aW9fZmQsIGdl
dHBhZ2VzaXplKCkpOwoJY2xvc2Uoc2l6ZV9mZCk7CgkKCXNpemVfZmQgPSBvcGVuKCBVSU9f
U0laRTIsIE9fUkRPTkxZICk7CglpZiggc2l6ZV9mZDwwICkgewoJCWZwcmludGYoc3RkZXJy
LCJDYW4ndCBvcGVuIFVJTyBmaWxlIDIuLi5cbiIpOwoJCXJldHVybiAtMTsKfQoJcmVhZCgg
c2l6ZV9mZCwgdWlvX3NpemVfYnVmLCBzaXplb2YodWlvX3NpemVfYnVmKSApOwoJdWlvX3Np
emUgPSAoaW50KXN0cnRvbCggdWlvX3NpemVfYnVmLCBOVUxMLCAwICk7CglCQVJbMl0gPSAo
QllURSAqKW1tYXAoTlVMTCwgdWlvX3NpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1B
UF9TSEFSRUQsIHVpb19mZCwgMipnZXRwYWdlc2l6ZSgpKTsKCWNsb3NlKHNpemVfZmQpOwoJ
cmV0dXJuKDApOwp9
--------------060903040401080304040105--
