// You can find instructions for this file here:
// http://www.treeview.net

// Decide if the names are links or just the icons
USETEXTLINKS = 1  //replace 0 with 1 for hyperlinks

// Decide if the tree is to start all open or just showing the root folders
STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree

ICONPATH = 'Support/' //change if the gif's folder is a subfolder, for example: 'images/'


USEICONS = 1

{
foldersTree = gFld("Title", "title.htm")
foldersTree.iconSrc = ICONPATH + "Gif/globe.gif"
Diag_Node = insFld(foldersTree, gFld("healthcare_claims_ddl.DM1", "diagram.htm"))
Diag_Node.iconSrc = ICONPATH + "Gif/diagram.gif"
Diag_Node.iconSrcClosed = ICONPATH + "Gif/diagram.gif"
Model_Node = insFld(Diag_Node, gFld("Logical", "Content/Model_cd09134ba49544158f9caab777c4b2b4.htm"))
Model_Node.iconSrc = ICONPATH + "Gif/logical.gif"
Model_Node.iconSrcClosed = ICONPATH + "Gif/logical.gif"
{
Submodel_d86c0c25b6be4be0a2a901b99b9baac3 = insFld(Model_Node, gFld("Main Model", "Content/Submodel_d86c0c25b6be4be0a2a901b99b9baac3.htm"))
Submodel_d86c0c25b6be4be0a2a901b99b9baac3.iconSrc = ICONPATH + "Gif/logmain.gif"
Submodel_d86c0c25b6be4be0a2a901b99b9baac3.iconSrcClosed = ICONPATH + "Gif/logmain.gif"
SubmodelImgNode = insDoc(Submodel_d86c0c25b6be4be0a2a901b99b9baac3, gLnk("R", "Model Image", "Content/Submodel_d86c0c25b6be4be0a2a901b99b9baac3_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_d86c0c25b6be4be0a2a901b99b9baac3, gFld("Entities", "Content/Sub_d86c0c25b6be4be0a2a901b99b9baac3_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_d86c0c25b6be4be0a2a901b99b9baac3, gFld("Attributes", "Content/Sub_d86c0c25b6be4be0a2a901b99b9baac3_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_d86c0c25b6be4be0a2a901b99b9baac3, gFld("Keys", "Content/Sub_d86c0c25b6be4be0a2a901b99b9baac3_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_d86c0c25b6be4be0a2a901b99b9baac3, gFld("Relationships", "Content/Sub_d86c0c25b6be4be0a2a901b99b9baac3_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
{
Submodel_9240ec29da3947e58c3d952fd98f91e1 = insFld(Model_Node, gFld("Claims Processing", "Content/Submodel_9240ec29da3947e58c3d952fd98f91e1.htm"))
Submodel_9240ec29da3947e58c3d952fd98f91e1.iconSrc = ICONPATH + "Gif/submodel.gif"
Submodel_9240ec29da3947e58c3d952fd98f91e1.iconSrcClosed = ICONPATH + "Gif/submodel.gif"
SubmodelImgNode = insDoc(Submodel_9240ec29da3947e58c3d952fd98f91e1, gLnk("R", "Model Image", "Content/Submodel_9240ec29da3947e58c3d952fd98f91e1_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_9240ec29da3947e58c3d952fd98f91e1, gFld("Entities", "Content/Sub_9240ec29da3947e58c3d952fd98f91e1_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_9240ec29da3947e58c3d952fd98f91e1, gFld("Attributes", "Content/Sub_9240ec29da3947e58c3d952fd98f91e1_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_9240ec29da3947e58c3d952fd98f91e1, gFld("Keys", "Content/Sub_9240ec29da3947e58c3d952fd98f91e1_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_9240ec29da3947e58c3d952fd98f91e1, gFld("Relationships", "Content/Sub_9240ec29da3947e58c3d952fd98f91e1_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
{
Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c = insFld(Model_Node, gFld("Clinical", "Content/Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c.htm"))
Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c.iconSrc = ICONPATH + "Gif/submodel.gif"
Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c.iconSrcClosed = ICONPATH + "Gif/submodel.gif"
SubmodelImgNode = insDoc(Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c, gLnk("R", "Model Image", "Content/Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c, gFld("Entities", "Content/Sub_af4dfa5ba24c41ae8f9d0c26f65d4c2c_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c, gFld("Attributes", "Content/Sub_af4dfa5ba24c41ae8f9d0c26f65d4c2c_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c, gFld("Keys", "Content/Sub_af4dfa5ba24c41ae8f9d0c26f65d4c2c_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_af4dfa5ba24c41ae8f9d0c26f65d4c2c, gFld("Relationships", "Content/Sub_af4dfa5ba24c41ae8f9d0c26f65d4c2c_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
{
Submodel_b09ab23583af444aa0d3eea519766366 = insFld(Model_Node, gFld("Denials and Appeals", "Content/Submodel_b09ab23583af444aa0d3eea519766366.htm"))
Submodel_b09ab23583af444aa0d3eea519766366.iconSrc = ICONPATH + "Gif/submodel.gif"
Submodel_b09ab23583af444aa0d3eea519766366.iconSrcClosed = ICONPATH + "Gif/submodel.gif"
SubmodelImgNode = insDoc(Submodel_b09ab23583af444aa0d3eea519766366, gLnk("R", "Model Image", "Content/Submodel_b09ab23583af444aa0d3eea519766366_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_b09ab23583af444aa0d3eea519766366, gFld("Entities", "Content/Sub_b09ab23583af444aa0d3eea519766366_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_b09ab23583af444aa0d3eea519766366, gFld("Attributes", "Content/Sub_b09ab23583af444aa0d3eea519766366_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_b09ab23583af444aa0d3eea519766366, gFld("Keys", "Content/Sub_b09ab23583af444aa0d3eea519766366_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_b09ab23583af444aa0d3eea519766366, gFld("Relationships", "Content/Sub_b09ab23583af444aa0d3eea519766366_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
{
Submodel_e051399849964c119c96393df9f3dae5 = insFld(Model_Node, gFld("Financial", "Content/Submodel_e051399849964c119c96393df9f3dae5.htm"))
Submodel_e051399849964c119c96393df9f3dae5.iconSrc = ICONPATH + "Gif/submodel.gif"
Submodel_e051399849964c119c96393df9f3dae5.iconSrcClosed = ICONPATH + "Gif/submodel.gif"
SubmodelImgNode = insDoc(Submodel_e051399849964c119c96393df9f3dae5, gLnk("R", "Model Image", "Content/Submodel_e051399849964c119c96393df9f3dae5_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_e051399849964c119c96393df9f3dae5, gFld("Entities", "Content/Sub_e051399849964c119c96393df9f3dae5_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_e051399849964c119c96393df9f3dae5, gFld("Attributes", "Content/Sub_e051399849964c119c96393df9f3dae5_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_e051399849964c119c96393df9f3dae5, gFld("Keys", "Content/Sub_e051399849964c119c96393df9f3dae5_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_e051399849964c119c96393df9f3dae5, gFld("Relationships", "Content/Sub_e051399849964c119c96393df9f3dae5_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
{
Submodel_a8f70af7ec464fcf9bea77950b754da0 = insFld(Model_Node, gFld("Patient Management", "Content/Submodel_a8f70af7ec464fcf9bea77950b754da0.htm"))
Submodel_a8f70af7ec464fcf9bea77950b754da0.iconSrc = ICONPATH + "Gif/submodel.gif"
Submodel_a8f70af7ec464fcf9bea77950b754da0.iconSrcClosed = ICONPATH + "Gif/submodel.gif"
SubmodelImgNode = insDoc(Submodel_a8f70af7ec464fcf9bea77950b754da0, gLnk("R", "Model Image", "Content/Submodel_a8f70af7ec464fcf9bea77950b754da0_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_a8f70af7ec464fcf9bea77950b754da0, gFld("Entities", "Content/Sub_a8f70af7ec464fcf9bea77950b754da0_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_a8f70af7ec464fcf9bea77950b754da0, gFld("Attributes", "Content/Sub_a8f70af7ec464fcf9bea77950b754da0_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_a8f70af7ec464fcf9bea77950b754da0, gFld("Keys", "Content/Sub_a8f70af7ec464fcf9bea77950b754da0_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_a8f70af7ec464fcf9bea77950b754da0, gFld("Relationships", "Content/Sub_a8f70af7ec464fcf9bea77950b754da0_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
{
Submodel_ab6522f119c54543b7d61d378bc6e742 = insFld(Model_Node, gFld("Provider Network", "Content/Submodel_ab6522f119c54543b7d61d378bc6e742.htm"))
Submodel_ab6522f119c54543b7d61d378bc6e742.iconSrc = ICONPATH + "Gif/submodel.gif"
Submodel_ab6522f119c54543b7d61d378bc6e742.iconSrcClosed = ICONPATH + "Gif/submodel.gif"
SubmodelImgNode = insDoc(Submodel_ab6522f119c54543b7d61d378bc6e742, gLnk("R", "Model Image", "Content/Submodel_ab6522f119c54543b7d61d378bc6e742_img.htm"))
SubmodelImgNode.iconSrc = ICONPATH + "Gif/image.gif"
SubmodelImgNode.altTxt = "Model Image"
EntityFolder = insFld(Submodel_ab6522f119c54543b7d61d378bc6e742, gFld("Entities", "Content/Sub_ab6522f119c54543b7d61d378bc6e742_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_ab6522f119c54543b7d61d378bc6e742, gFld("Attributes", "Content/Sub_ab6522f119c54543b7d61d378bc6e742_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_ab6522f119c54543b7d61d378bc6e742, gFld("Keys", "Content/Sub_ab6522f119c54543b7d61d378bc6e742_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_ab6522f119c54543b7d61d378bc6e742, gFld("Relationships", "Content/Sub_ab6522f119c54543b7d61d378bc6e742_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
Model_Node = insFld(Diag_Node, gFld("Physical", "Content/Model_2e5329d677ee469f98f3f322046d9746.htm"))
Model_Node.iconSrc = ICONPATH + "Gif/physical.gif"
Model_Node.iconSrcClosed = ICONPATH + "Gif/physical.gif"
{
Submodel_d50d02628641487c9683e28e62e51b2b = insFld(Model_Node, gFld("Main Model", "Content/Submodel_d50d02628641487c9683e28e62e51b2b.htm"))
Submodel_d50d02628641487c9683e28e62e51b2b.iconSrc = ICONPATH + "Gif/grnfldr.gif"
Submodel_d50d02628641487c9683e28e62e51b2b.iconSrcClosed = ICONPATH + "Gif/grnfldr.gif"
EntityFolder = insFld(Submodel_d50d02628641487c9683e28e62e51b2b, gFld("Tables", "Content/Sub_d50d02628641487c9683e28e62e51b2b_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
AttrFolder = insFld(Submodel_d50d02628641487c9683e28e62e51b2b, gFld("Columns", "Content/Sub_d50d02628641487c9683e28e62e51b2b_AttrFrame.htm"))
AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
IndexFolder = insFld(Submodel_d50d02628641487c9683e28e62e51b2b, gFld("Indexes", "Content/Sub_d50d02628641487c9683e28e62e51b2b_IdxFrame.htm"))
IndexFolder.iconSrc = ICONPATH + "Gif/index.gif"
IndexFolder.iconSrcClosed = ICONPATH + "Gif/index.gif"
RelFolder = insFld(Submodel_d50d02628641487c9683e28e62e51b2b, gFld("Foreign Keys", "Content/Sub_d50d02628641487c9683e28e62e51b2b_RelFrame.htm"))
RelFolder.iconSrc = ICONPATH + "Gif/relfldr.gif"
RelFolder.iconSrcClosed = ICONPATH + "Gif/relfldr.gif"
}
}
