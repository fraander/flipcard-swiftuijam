//
//  NewCardView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct NewCardView: View {
	@Binding var newCardViewShowing: Bool
	@State var term = ""
	@State var definition = ""
	
	var body: some View {
		#if os(iOS)
		NavigationView {
			VStack(spacing: 0) {
				
				Divider()
				
				Spacer()
					.frame(height: 20)
				
				Text("Term")
					.font(.caption)
					.bold()
					.frame(maxWidth: .infinity, alignment: .leading)
				TextField("Term", text: $term)
					.textFieldStyle(.roundedBorder)
				
				Spacer()
					.frame(height: 20)
				
				Text("Definition")
					.font(.caption)
					.bold()
					.frame(maxWidth: .infinity, alignment: .leading)
				TextField("Definition", text: $definition)
					.textFieldStyle(.roundedBorder)
				
				Spacer()
				
				Button {
					addCard()
					dismiss()
				} label: {
					Text("Add Card")
						.font(.headline)
						.frame(maxWidth: .infinity, minHeight: 40)
				}
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				
			}
			.padding()
			.toolbar {
				#if os(iOS)
				ToolbarItem(placement: .navigationBarLeading) {
					Button("Cancel") {
						dismiss()
					}
					.tint(.orange)
				}
				#endif
			}
			.navigationTitle("Add Card")
		}
		#else
		VStack {
			TextField("Term", text: $term)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					addCard()
					dismiss()
				}
				.onExitCommand {
					dismiss()
				}
			TextField("Definition", text: $definition)
				.textFieldStyle(.roundedBorder)
				.onSubmit {
					addCard()
					dismiss()
				}
				.onExitCommand {
					dismiss()
				}
			
			HStack {
				
				Button("Cancel") {
					dismiss()
				}
				.tint(.orange)
				.keyboardShortcut(.cancelAction)
				
				Button {
					addCard()
					dismiss()
				} label: {
					Text("Add Card")
						.font(.headline)
				}
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				.keyboardShortcut(.defaultAction)
			}
		}
		.padding()
		#endif
	}
	
	func addCard() {
		CoreDataHelper.addCard(term: term, definition: definition)
	}
	
	func dismiss() {
		newCardViewShowing = false
	}
}

struct NewCardView_Previews: PreviewProvider {
	static var previews: some View {
		NewCardView(newCardViewShowing: .constant(true))
			.preferredColorScheme(.light)
		
		NewCardView(newCardViewShowing: .constant(true))
			.preferredColorScheme(.dark)
	}
}
